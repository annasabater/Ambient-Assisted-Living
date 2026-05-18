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
        ZStack {
            AppTheme.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: Spacing.m) {
                    AuthHeader(
                        icon: "figure.2.and.child.holdinghands",
                        title: "Ambient Assisted Living",
                        subtitle: "Cuida a quienes más quieres"
                    )

                    VStack(spacing: Spacing.s) {
                        TextField("Email", text: $email)
                            .brandField()
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .textContentType(.emailAddress)
                        SecureField("Contraseña", text: $password)
                            .brandField()
                            .textContentType(.password)
                    }

                    Button(action: submit) {
                        if isSubmitting {
                            ProgressView().tint(.white)
                        } else {
                            Text("Iniciar sesión")
                        }
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .disabled(!canSubmit)

                    NavigationLink("¿Olvidaste tu contraseña?") {
                        ForgotPasswordView()
                    }
                    .font(Typography.callout)
                    .foregroundStyle(AppTheme.primary)
                    .padding(.top, Spacing.xs)

                    Spacer(minLength: Spacing.l)

                    HStack(spacing: 4) {
                        Text("¿No tienes cuenta?")
                            .foregroundStyle(AppTheme.textSecondary)
                        NavigationLink("Regístrate") { RegisterView() }
                            .foregroundStyle(AppTheme.primary)
                            .fontWeight(.semibold)
                    }
                    .font(Typography.callout)
                    .padding(.bottom, Spacing.s)
                }
                .padding(.horizontal, Spacing.l)
                .padding(.top, Spacing.l)
            }
        }
        .navigationBarHidden(true)
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
