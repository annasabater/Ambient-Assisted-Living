//
//  AuthService.swift
//  Ambient Assisted Living
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import os

@MainActor
final class AuthService: ObservableObject {
    @Published private(set) var currentUser: AppUser?
    @Published private(set) var firebaseUser: User?
    @Published private(set) var isLoading: Bool = false

    private let auth: Auth
    private let usersCollection: CollectionReference
    private let logger = Logger(subsystem: "lasalle.AAL", category: "Auth")
    private var stateHandle: AuthStateDidChangeListenerHandle?

    init() {
        self.auth = Auth.auth()
        self.usersCollection = Firestore.firestore().collection("users")
        self.firebaseUser = auth.currentUser
        startObservingAuthState()
    }

    deinit {
        if let stateHandle {
            auth.removeStateDidChangeListener(stateHandle)
        }
    }

    // MARK: - Public API

    func login(email: String, password: String) async throws {
        isLoading = true
        defer { isLoading = false }
        do {
            let result = try await auth.signIn(withEmail: email, password: password)
            logger.info("login ok uid=\(result.user.uid, privacy: .public)")
            await loadOrCreateProfile(for: result.user)
        } catch {
            logger.error("login failed: \(error.localizedDescription, privacy: .public)")
            throw AppError.map(error)
        }
    }

    func register(email: String, password: String) async throws {
        isLoading = true
        defer { isLoading = false }
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            logger.info("register ok uid=\(result.user.uid, privacy: .public)")
            await loadOrCreateProfile(for: result.user)
        } catch {
            logger.error("register failed: \(error.localizedDescription, privacy: .public)")
            throw AppError.map(error)
        }
    }

    func signOut() throws {
        do {
            try auth.signOut()
            currentUser = nil
            logger.info("signOut ok")
        } catch {
            logger.error("signOut failed: \(error.localizedDescription, privacy: .public)")
            throw AppError.map(error)
        }
    }

    // MARK: - Internals

    private func startObservingAuthState() {
        stateHandle = auth.addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor [weak self] in
                guard let self else { return }
                self.firebaseUser = user
                if let user {
                    await self.loadOrCreateProfile(for: user)
                } else {
                    self.currentUser = nil
                }
            }
        }
    }

    private func loadOrCreateProfile(for user: User) async {
        do {
            let doc = try await usersCollection.document(user.uid).getDocument()
            if doc.exists {
                self.currentUser = try doc.data(as: AppUser.self)
                logger.info("profile loaded uid=\(user.uid, privacy: .public)")
            } else {
                let newUser = AppUser(
                    id: nil,
                    email: user.email ?? "",
                    displayName: "",
                    phone: nil,
                    createdAt: Date()
                )
                let data = try Firestore.Encoder().encode(newUser)
                try await usersCollection.document(user.uid).setData(data)
                let created = try await usersCollection.document(user.uid).getDocument()
                self.currentUser = try created.data(as: AppUser.self)
                logger.info("profile created uid=\(user.uid, privacy: .public)")
            }
        } catch {
            logger.error("loadOrCreateProfile failed: \(error.localizedDescription, privacy: .public)")
            self.currentUser = nil
        }
    }
}
