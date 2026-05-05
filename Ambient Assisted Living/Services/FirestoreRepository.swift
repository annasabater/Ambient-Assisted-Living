//
//  FirestoreRepository.swift
//  Ambient Assisted Living
//

import Foundation
import FirebaseFirestore
import os

/// Generic Firestore repository for `@DocumentID`-based models.
///
/// `T.ID == String?` matches every model in `Models/` that uses
/// `@DocumentID var id: String?`.
final class FirestoreRepository<T: Codable & Identifiable> where T.ID == String? {
    private let collection: CollectionReference
    private let logger: Logger

    init(collectionPath: String) {
        self.collection = Firestore.firestore().collection(collectionPath)
        self.logger = Logger(subsystem: "lasalle.AAL", category: "Firestore")
    }

    // MARK: - Read

    func list(query: Query? = nil) async throws -> [T] {
        let q = query ?? collection
        do {
            let snapshot = try await q.getDocuments()
            return decode(snapshot.documents)
        } catch {
            logger.error("list failed: \(error.localizedDescription, privacy: .public)")
            throw AppError.map(error)
        }
    }

    func get(id: String) async throws -> T? {
        do {
            let doc = try await collection.document(id).getDocument()
            guard doc.exists else { return nil }
            return try doc.data(as: T.self)
        } catch let error as DecodingError {
            logger.error("get decode error: \(String(describing: error), privacy: .public)")
            throw AppError.decodingError
        } catch {
            logger.error("get failed: \(error.localizedDescription, privacy: .public)")
            throw AppError.map(error)
        }
    }

    /// Real-time listener exposed as an AsyncStream. Cancelling the stream
    /// (or terminating the consuming task) removes the underlying listener.
    func observe(query: Query? = nil) -> AsyncStream<[T]> {
        let q = query ?? collection
        let logger = self.logger
        let decode = self.decode
        return AsyncStream { continuation in
            let listener = q.addSnapshotListener { snapshot, error in
                if let error {
                    logger.error("observe error: \(error.localizedDescription, privacy: .public)")
                    return
                }
                guard let snapshot else { return }
                continuation.yield(decode(snapshot.documents))
            }
            continuation.onTermination = { _ in
                listener.remove()
            }
        }
    }

    // MARK: - Write

    func create(_ item: T) async throws -> String {
        do {
            let docRef = collection.document()
            let data = try Firestore.Encoder().encode(item)
            try await docRef.setData(data)
            return docRef.documentID
        } catch let error as EncodingError {
            logger.error("create encode error: \(String(describing: error), privacy: .public)")
            throw AppError.decodingError
        } catch {
            logger.error("create failed: \(error.localizedDescription, privacy: .public)")
            throw AppError.map(error)
        }
    }

    func update(_ item: T) async throws {
        guard let id = item.id else {
            logger.error("update called with nil id")
            throw AppError.unknown(NSError(
                domain: "FirestoreRepository",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Cannot update a model without an id."]
            ))
        }
        do {
            let data = try Firestore.Encoder().encode(item)
            try await collection.document(id).setData(data, merge: true)
        } catch let error as EncodingError {
            logger.error("update encode error: \(String(describing: error), privacy: .public)")
            throw AppError.decodingError
        } catch {
            logger.error("update failed: \(error.localizedDescription, privacy: .public)")
            throw AppError.map(error)
        }
    }

    func delete(id: String) async throws {
        do {
            try await collection.document(id).delete()
        } catch {
            logger.error("delete failed: \(error.localizedDescription, privacy: .public)")
            throw AppError.map(error)
        }
    }

    // MARK: - Helpers

    private func decode(_ documents: [QueryDocumentSnapshot]) -> [T] {
        documents.compactMap { doc in
            do {
                return try doc.data(as: T.self)
            } catch {
                logger.error("decode skip \(doc.documentID, privacy: .public): \(error.localizedDescription, privacy: .public)")
                return nil
            }
        }
    }
}
