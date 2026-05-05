//
//  App.swift
//  Ambient Assisted Living
//

import SwiftUI
import FirebaseCore
import FirebaseMessaging

@main
struct AmbientAssistedLivingApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
