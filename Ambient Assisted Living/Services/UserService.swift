//
//  UserService.swift
//  Ambient Assisted Living
//

import Foundation
import FirebaseAuth
import os

@MainActor
final class UserService: ObservableObject {
    private let repo: FirestoreRepository<AppUser>
    private let logger = Logger(subsystem: "lasalle.AAL", category: "User")

    init(repo: FirestoreRepository<AppUser> = FirestoreRepository<AppUser>(collectionPath: "users")) {
        self.repo = repo
    }

    /// Reads the AppUser doc for the currently authenticated caregiver.
    func currentProfile() async throws -> AppUser? {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw AppError.notAuthenticated
        }
        return try await repo.get(id: uid)
    }

    /// Patches `displayName` and `phone` on the current caregiver's
    /// `users/{uid}` document. Throws `.notAuthenticated` if no Firebase
    /// user is signed in.
    func updateProfile(displayName: String, phone: String?) async throws {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw AppError.notAuthenticated
        }
        guard var user = try await repo.get(id: uid) else {
            logger.error("updateProfile: missing AppUser doc for uid=\(uid, privacy: .public)")
            throw AppError.unknown(NSError(
                domain: "UserService",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Profile document not found."]
            ))
        }
        user.displayName = displayName
        user.phone = phone
        try await repo.update(user)
        logger.info("profile updated uid=\(uid, privacy: .public)")
    }
}
