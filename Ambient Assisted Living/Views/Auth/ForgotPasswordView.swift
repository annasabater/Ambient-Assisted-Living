//
//  ForgotPasswordView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct ForgotPasswordView: View {
    @EnvironmentObject private var authService: AuthService

    @State private var email: String = ""
    @State private var isSubmitting: Bool = false
    @State private var didSendEmail: Bool = false
    @State private var errorMessage: String?

    private var canSubmit: Bool {
        !isSubmitting && !email.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        Form {
            Section {
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .textContentType(.emailAddress)
            } footer: {
                Text("Te enviaremos un enlace para restablecer tu contraseña.")
            }

            Section {
                Button(action: submit) {
                    HStack {
                        if isSubmitting { ProgressView().padding(.trailing, 4) }
                        Text("Enviar email de recuperación")
                            .frame(maxWidth: .infinity)
                    }
                }
                .disabled(!canSubmit)
            }

            if didSendEmail {
                Section {
                    Label(
                        "Te hemos enviado un email para recuperar tu contraseña.",
                        systemImage: "checkmark.circle.fill"
                    )
                    .foregroundStyle(.green)
                }
            }
        }
        .navigationTitle("Recuperar contraseña")
        .alert(
            "No se pudo enviar el email",
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
            didSendEmail = false
            do {
                try await authService.sendPasswordReset(
                    email: email.trimmingCharacters(in: .whitespacesAndNewlines)
                )
                didSendEmail = true
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
        ForgotPasswordView()
            .environmentObject(AuthService())
    }
}
