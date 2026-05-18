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
            }
            .tabItem {
                Label("Inicio", systemImage: "house.fill")
            }

            NavigationStack {
                MonitoringView()
            }
            .tabItem {
                Label("Monitorización", systemImage: "heart.text.square.fill")
            }

            NavigationStack {
                ControlView()
            }
            .tabItem {
                Label("Control", systemImage: "lightbulb.fill")
            }

            NavigationStack {
                AlertsView()
            }
            .tabItem {
                Label("Alertas", systemImage: "bell.fill")
            }
            .badge(alertsCount)

            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label("Ajustes", systemImage: "gearshape.fill")
            }
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(AuthService())
        .environmentObject(UserService())
}
