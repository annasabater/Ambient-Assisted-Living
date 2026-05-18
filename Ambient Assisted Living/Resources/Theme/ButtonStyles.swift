//
//  ButtonStyles.swift
//  Ambient Assisted Living
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.weight(.semibold))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 20)
            .background(AppTheme.primary)
            .clipShape(RoundedRectangle(cornerRadius: Radius.m, style: .continuous))
            .opacity(configuration.isPressed ? 0.6 : 1.0)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.weight(.medium))
            .foregroundStyle(AppTheme.primary)
            .padding(.vertical, 14)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
    }
}

struct DestructiveButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.weight(.semibold))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 20)
            .background(AppTheme.danger)
            .clipShape(RoundedRectangle(cornerRadius: Radius.m, style: .continuous))
            .opacity(configuration.isPressed ? 0.6 : 1.0)
    }
}
