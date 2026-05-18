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
        return name.isEmpty ? "Sin nombre" : name
    }

    private var email: String {
        authService.currentUser?.email ?? ""
    }

    private var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "—"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "—"
        return "\(version) (\(build))"
    }

    var body: some View {
        Form {
            Section("Perfil") {
                VStack(alignment: .leading, spacing: 4) {
                    Text(displayName)
                        .font(.body)
                    Text(email)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 2)
            }

            Section("Dispositivos") {
                Text("Gestionar dispositivos")
            }

            Section("Notificaciones") {
                Text("Preferencias")
            }

            Section("Contactos de emergencia") {
                Text("Gestionar contactos")
            }

            Section("Cuenta") {
                Button(role: .destructive, action: signOut) {
                    Text("Cerrar sesión")
                }
            }

            Section("Acerca de") {
                LabeledContent("Versión", value: appVersion)
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
