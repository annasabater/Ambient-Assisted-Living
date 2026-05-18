//
//  EnvironmentCard.swift
//  Ambient Assisted Living
//

import SwiftUI

struct EnvironmentCard: View {
    let title: String
    let value: String
    let unit: String
    let icon: String
    let statusColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.s) {
            HStack(spacing: Spacing.xs) {
                Image(systemName: icon)
                    .font(.system(size: 14))
                    .foregroundStyle(statusColor)
                Text(title)
                    .font(Typography.footnote)
                    .foregroundStyle(.secondary)
            }
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(value)
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundStyle(AppTheme.textPrimary)
                Text(unit)
                    .font(Typography.callout)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(Spacing.m)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: Radius.l, style: .continuous))
    }
}

#Preview {
    VStack(spacing: Spacing.m) {
        EnvironmentCard(
            title: "Temperatura",
            value: "21.5",
            unit: "°C",
            icon: "thermometer",
            statusColor: AppTheme.success
        )
        EnvironmentCard(
            title: "Humedad",
            value: "68",
            unit: "%",
            icon: "humidity.fill",
            statusColor: AppTheme.warning
        )
        EnvironmentCard(
            title: "Temperatura",
            value: "30.2",
            unit: "°C",
            icon: "thermometer",
            statusColor: AppTheme.danger
        )
    }
    .padding()
    .background(AppTheme.background)
}
