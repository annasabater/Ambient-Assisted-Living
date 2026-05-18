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
        VStack(spacing: Spacing.s) {
            Image(systemName: icon)
                .font(.system(size: 44))
                .foregroundStyle(AppTheme.primary)
                .padding(.bottom, Spacing.xs)
            Text(title)
                .font(Typography.displayTitle)
                .multilineTextAlignment(.center)
            Text(subtitle)
                .font(Typography.callout)
                .foregroundStyle(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, Spacing.l)
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
