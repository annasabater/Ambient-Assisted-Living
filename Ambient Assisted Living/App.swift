//
//  App.swift
//  Ambient Assisted Living
//

import SwiftUI
import FirebaseCore
import FirebaseMessaging

@main
struct AmbientAssistedLivingApp: App {
    @StateObject private var authService = AuthService()
    @StateObject private var userService = UserService()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authService)
                .environmentObject(userService)
        }
    }
}
