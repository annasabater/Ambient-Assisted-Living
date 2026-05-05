//
//  RegisterView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject private var authService: AuthService
    @EnvironmentObject private var userService: UserService

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
        Form {
            Section("Cuenta") {
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .textContentType(.emailAddress)
                if !email.isEmpty && !emailIsValid {
                    inlineHint("Introduce un email válido.")
                }

                SecureField("Contraseña", text: $password)
                    .textContentType(.newPassword)
                if !password.isEmpty && !passwordIsValid {
                    inlineHint("La contraseña debe tener al menos 8 caracteres.")
                }

                SecureField("Confirmar contraseña", text: $confirmPassword)
                    .textContentType(.newPassword)
                if !confirmPassword.isEmpty && !passwordsMatch {
                    inlineHint("Las contraseñas no coinciden.")
                }
            }

            Section("Perfil") {
                TextField("Nombre", text: $displayName)
                    .textContentType(.name)
                if !displayName.isEmpty && !displayNameIsValid {
                    inlineHint("Introduce tu nombre.")
                }

                TextField("Teléfono (opcional)", text: $phone)
                    .keyboardType(.phonePad)
                    .textContentType(.telephoneNumber)
            }

            Section {
                Button(action: submit) {
                    HStack {
                        if isSubmitting { ProgressView().padding(.trailing, 4) }
                        Text("Crear cuenta")
                            .frame(maxWidth: .infinity)
                    }
                }
                .disabled(!canSubmit)
            }
        }
        .navigationTitle("Crear cuenta")
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
            .font(.caption)
            .foregroundStyle(.red)
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
