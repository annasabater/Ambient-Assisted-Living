//
//  LoginView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var authService: AuthService

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSubmitting: Bool = false
    @State private var errorMessage: String?

    private var canSubmit: Bool {
        !isSubmitting && !email.trimmingCharacters(in: .whitespaces).isEmpty && !password.isEmpty
    }

    var body: some View {
        Form {
            Section("Credenciales") {
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .textContentType(.emailAddress)
                SecureField("Contraseña", text: $password)
                    .textContentType(.password)
            }

            Section {
                Button(action: submit) {
                    HStack {
                        if isSubmitting { ProgressView().padding(.trailing, 4) }
                        Text("Iniciar sesión")
                            .frame(maxWidth: .infinity)
                    }
                }
                .disabled(!canSubmit)
            }

            Section {
                NavigationLink("¿No tienes cuenta? Regístrate") {
                    RegisterView()
                }
                NavigationLink("¿Olvidaste tu contraseña?") {
                    ForgotPasswordView()
                }
            }
        }
        .navigationTitle("Iniciar sesión")
        .alert(
            "No se pudo iniciar sesión",
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

    private func submit() {
        Task {
            isSubmitting = true
            defer { isSubmitting = false }
            do {
                try await authService.signIn(email: email, password: password)
            } catch let error as AppError {
                errorMessage = error.errorDescription
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
            .environmentObject(AuthService())
    }
}
