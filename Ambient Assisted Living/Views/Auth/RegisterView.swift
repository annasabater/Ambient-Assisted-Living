//
//  RegisterView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject private var authService: AuthService
    @EnvironmentObject private var userService: UserService
    @Environment(\.dismiss) private var dismiss

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var displayName: String = ""
    @State private var phone: String = ""
    @State private var isSubmitting: Bool = false
    @State private var errorMessage: String?

    // MARK: - Validation

    private var trimmedEmail: String { email.trimmingCharacters(in: .whitespacesAndNewlines) }
    private var trimmedDisplayName: String { displayName.trimmingCharacters(in: .whitespacesAndNewlines) }

    private var emailIsValid: Bool {
        let regex = #"^[A-Z0-9a-z._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$"#
        return trimmedEmail.range(of: regex, options: .regularExpression) != nil
    }
    private var passwordIsValid: Bool { password.count >= 8 }
    private var passwordsMatch: Bool { !confirmPassword.isEmpty && password == confirmPassword }
    private var displayNameIsValid: Bool { !trimmedDisplayName.isEmpty }

    private var canSubmit: Bool {
        !isSubmitting && emailIsValid && passwordIsValid && passwordsMatch && displayNameIsValid
    }

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()

            ScrollView {
                VStack(spacing: Spacing.l) {
                    AuthHeader(
                        icon: "person.crop.circle.badge.plus",
                        title: "Crear cuenta",
                        subtitle: "Empieza a cuidar a tu ser querido"
                    )

                    VStack(spacing: Spacing.m) {
                        VStack(alignment: .leading, spacing: Spacing.xs) {
                            TextField("Nombre", text: $displayName)
                                .brandField()
                                .textContentType(.name)
                            if !displayName.isEmpty && !displayNameIsValid {
                                inlineHint("Introduce tu nombre.")
                            }
                        }

                        VStack(alignment: .leading, spacing: Spacing.xs) {
                            TextField("Email", text: $email)
                                .brandField()
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled(true)
                                .textContentType(.emailAddress)
                            if !email.isEmpty && !emailIsValid {
                                inlineHint("Introduce un email válido.")
                            }
                        }

                        TextField("Teléfono (opcional)", text: $phone)
                            .brandField()
                            .keyboardType(.phonePad)
                            .textContentType(.telephoneNumber)

                        VStack(alignment: .leading, spacing: Spacing.xs) {
                            SecureField("Contraseña", text: $password)
                                .brandField()
                                .textContentType(.newPassword)
                            if !password.isEmpty && !passwordIsValid {
                                inlineHint("La contraseña debe tener al menos 8 caracteres.")
                            }
                        }

                        VStack(alignment: .leading, spacing: Spacing.xs) {
                            SecureField("Confirmar contraseña", text: $confirmPassword)
                                .brandField()
                                .textContentType(.newPassword)
                            if !confirmPassword.isEmpty && !passwordsMatch {
                                inlineHint("Las contraseñas no coinciden.")
                            }
                        }
                    }

                    Button(action: submit) {
                        if isSubmitting {
                            ProgressView().tint(.white)
                        } else {
                            Text("Crear cuenta")
                        }
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .disabled(!canSubmit)

                    Spacer(minLength: Spacing.xl)

                    HStack(spacing: 4) {
                        Text("¿Ya tienes cuenta?")
                            .foregroundStyle(AppTheme.textSecondary)
                        Button("Inicia sesión") { dismiss() }
                            .foregroundStyle(AppTheme.primary)
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                    .padding(.bottom, Spacing.m)
                }
                .padding(.horizontal, Spacing.l)
                .padding(.top, Spacing.l)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert(
            "No se pudo crear la cuenta",
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

    private func inlineHint(_ text: String) -> some View {
        Text(text)
            .font(.footnote)
            .foregroundStyle(AppTheme.danger)
            .padding(.leading, Spacing.m)
    }

    private func submit() {
        Task {
            isSubmitting = true
            defer { isSubmitting = false }
            do {
                try await authService.register(email: trimmedEmail, password: password)
                let phoneValue = phone.trimmingCharacters(in: .whitespacesAndNewlines)
                try await userService.updateProfile(
                    displayName: trimmedDisplayName,
                    phone: phoneValue.isEmpty ? nil : phoneValue
                )
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
        RegisterView()
            .environmentObject(AuthService())
            .environmentObject(UserService())
    }
}
