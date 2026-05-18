//
//  StatusBadge.swift
//  Ambient Assisted Living
//

import SwiftUI

struct StatusBadge: View {
    let text: String
    let color: Color

    var body: some View {
        HStack(spacing: Spacing.xs) {
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
            Text(text)
                .font(Typography.callout)
                .fontWeight(.medium)
                .foregroundStyle(color)
        }
        .padding(.horizontal, Spacing.m)
        .padding(.vertical, Spacing.s)
        .background(color.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: Radius.xl, style: .continuous))
    }
}

#Preview {
    VStack(spacing: Spacing.m) {
        StatusBadge(text: "Confortable", color: AppTheme.success)
        StatusBadge(text: "Atención", color: AppTheme.warning)
        StatusBadge(text: "Alerta", color: AppTheme.danger)
    }
    .padding()
    .background(AppTheme.background)
}
