//
//  DashboardView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var authService: AuthService
    @State private var errorMessage: String?

    private var greetingName: String {
        if let name = authService.currentUser?.displayName, !name.isEmpty {
            return name
        }
        return authService.currentUser?.email ?? ""
    }

    var body: some View {
        VStack(spacing: 24) {
            Text("Hola, \(greetingName)")
                .font(.title2.bold())
                .multilineTextAlignment(.center)

            Text("Aquí verás el resumen del estado de la persona monitorizada")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            Button(role: .destructive, action: signOut) {
                Text("Cerrar sesión")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
        }
        .padding()
        .navigationTitle("Inicio")
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
        DashboardView()
            .environmentObject(AuthService())
    }
}
