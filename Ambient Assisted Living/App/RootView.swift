//
//  RootView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var authService: AuthService

    var body: some View {
        Group {
            if authService.isInitializing {
                splash
            } else if authService.currentUser != nil {
                MainTabView()
            } else {
                NavigationStack {
                    LoginView()
                }
            }
        }
    }

    private var splash: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart.text.square.fill")
                .font(.system(size: 64))
                .foregroundStyle(.tint)
            ProgressView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    RootView()
        .environmentObject(AuthService())
        .environmentObject(UserService())
}
