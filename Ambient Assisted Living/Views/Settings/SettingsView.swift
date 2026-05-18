//
//  SettingsView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var authService: AuthService
    @State private var errorMessage: String?

    private var displayName: String {
        let name = authService.currentUser?.displayName ?? ""
        return name.isEmpty ? "Usuario" : name
    }

    private var email: String {
        authService.currentUser?.email ?? ""
    }

    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }

    private var buildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
    }

    var body: some View {
        Form {
            Section {
                HStack(spacing: Spacing.s) {
                    ZStack {
                        Circle()
                            .fill(AppTheme.primaryLight)
                            .frame(width: 48, height: 48)
                        Image(systemName: "person.fill")
                            .foregroundStyle(AppTheme.primary)
                            .font(.system(size: 20))
                    }
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        Text(displayName)
                            .font(Typography.headline)
                        Text(email)
                            .font(Typography.footnote)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }
                .padding(.vertical, Spacing.xs)
            }

            Section("Persona monitorizada") {
                NavigationLink {
                    EmptyView()
                } label: {
                    Label("Gestionar perfil", systemImage: "person.crop.circle")
                }
                NavigationLink {
                    EmptyView()
                } label: {
                    Label("Contactos de emergencia", systemImage: "phone.fill")
                }
            }

            Section("Dispositivos") {
                NavigationLink {
                    EmptyView()
                } label: {
                    Label("Mis dispositivos", systemImage: "wifi.router")
                }
                NavigationLink {
                    EmptyView()
                } label: {
                    Label("Añadir nuevo dispositivo", systemImage: "plus.circle.fill")
                }
            }

            Section("Notificaciones") {
                NavigationLink {
                    EmptyView()
                } label: {
                    Label("Preferencias de alertas", systemImage: "bell.badge")
                }
            }

            Section("Cuenta") {
                NavigationLink {
                    EmptyView()
                } label: {
                    Label("Editar perfil", systemImage: "pencil")
                }
                Button(role: .destructive) {
                    signOut()
                } label: {
                    Label("Cerrar sesión", systemImage: "rectangle.portrait.and.arrow.right")
                }
            }

            Section("Acerca de") {
                HStack {
                    Text("Versión")
                        .font(Typography.callout)
                    Spacer()
                    Text(appVersion)
                        .font(Typography.callout)
                        .foregroundStyle(.secondary)
                }
                HStack {
                    Text("Build")
                        .font(Typography.callout)
                    Spacer()
                    Text(buildNumber)
                        .font(Typography.callout)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Ajustes")
        .alert(
            "No se pudo cerrar sesión",
            isPresented: Binding(
                get: { errorMessage != nil },
                set: { if !$0 { errorMessage = nil } }
            ),
            presenting: errorMessage
        ) { _ in
            Button("OK", role: .cancel) { errorMessage = nil }
        } message: { message in
            Text(message)
        }
    }

    private func signOut() {
        do {
            try authService.signOut()
        } catch let error as AppError {
            errorMessage = error.errorDescription
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environmentObject(AuthService())
    }
}
