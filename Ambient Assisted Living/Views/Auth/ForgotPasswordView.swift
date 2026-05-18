//
//  ForgotPasswordView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct ForgotPasswordView: View {
    @EnvironmentObject private var authService: AuthService
    @Environment(\.dismiss) private var dismiss

    @State private var email: String = ""
    @State private var isSubmitting: Bool = false
    @State private var sent: Bool = false
    @State private var errorMessage: String?

    private var canSubmit: Bool {
        !isSubmitting && !email.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: Spacing.l) {
                    AuthHeader(
                        icon: "key.fill",
                        title: "Recuperar contraseña",
                        subtitle: "Te enviaremos un email para restablecerla"
                    )

                    if sent {
                        successView
                            .transition(.opacity.combined(with: .scale))
                    } else {
                        formView
                            .transition(.opacity.combined(with: .scale))
                    }
                }
                .padding(.horizontal, Spacing.l)
                .padding(.top, Spacing.l)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
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

    private var formView: some View {
        VStack(spacing: Spacing.l) {
            TextField("Email", text: $email)
                .brandField()
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .textContentType(.emailAddress)

            Button(action: submit) {
                if isSubmitting {
                    ProgressView().tint(.white)
                } else {
                    Text("Enviar email")
                }
            }
            .buttonStyle(PrimaryButtonStyle())
            .disabled(!canSubmit)
        }
    }

    private var successView: some View {
        VStack(spacing: Spacing.m) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 56))
                .foregroundStyle(AppTheme.success)
            Text("Email enviado")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Revisa tu bandeja de entrada y sigue las instrucciones")
                .font(.body)
                .foregroundStyle(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
            Button("Volver al inicio") { dismiss() }
                .buttonStyle(SecondaryButtonStyle())
                .padding(.top, Spacing.m)
        }
        .padding(.horizontal, Spacing.l)
    }

    private func submit() {
        Task {
            isSubmitting = true
            defer { isSubmitting = false }
            do {
                try await authService.sendPasswordReset(
                    email: email.trimmingCharacters(in: .whitespacesAndNewlines)
                )
                withAnimation(.easeInOut) {
                    sent = true
                }
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
