//
//  MainTabView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct MainTabView: View {
    @State private var alertsCount: Int = 0

    var body: some View {
        TabView {
            NavigationStack {
                DashboardView()
                    .toolbarBackground(.visible, for: .tabBar)
            }
            .tabItem {
                Label("Inicio", systemImage: "house.fill")
            }

            NavigationStack {
                MonitoringView()
                    .toolbarBackground(.visible, for: .tabBar)
            }
            .tabItem {
                Label("Monitorización", systemImage: "heart.text.square.fill")
            }

            NavigationStack {
                ControlView()
                    .toolbarBackground(.visible, for: .tabBar)
            }
            .tabItem {
                Label("Control", systemImage: "lightbulb.fill")
            }

            NavigationStack {
                AlertsView()
                    .toolbarBackground(.visible, for: .tabBar)
            }
            .tabItem {
                Label("Alertas", systemImage: "bell.fill")
            }
            .badge(alertsCount)

            NavigationStack {
                SettingsView()
                    .toolbarBackground(.visible, for: .tabBar)
            }
            .tabItem {
                Label("Ajustes", systemImage: "gearshape.fill")
            }
        }
        .tint(AppTheme.primary)
    }
}

#Preview {
    MainTabView()
        .environmentObject(AuthService())
        .environmentObject(UserService())
}
