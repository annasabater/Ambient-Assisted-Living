//
//  AuthHeader.swift
//  Ambient Assisted Living
//

import SwiftUI

struct AuthHeader: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        VStack(spacing: Spacing.m) {
            Image(systemName: icon)
                .font(.system(size: 64))
                .foregroundStyle(AppTheme.primary)
                .padding(.bottom, Spacing.s)
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Text(subtitle)
                .font(.body)
                .foregroundStyle(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, Spacing.xl)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    AuthHeader(
        icon: "figure.2.and.child.holdinghands",
        title: "Ambient Assisted Living",
        subtitle: "Cuida a quienes más quieres"
    )
}
