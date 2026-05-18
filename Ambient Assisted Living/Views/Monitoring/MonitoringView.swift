//
//  MonitoringView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct MonitoringView: View {
    var body: some View {
        List {
            NavigationLink {
                FallsView()
            } label: {
                row(icon: "figure.fall",
                    title: "Detección de caídas",
                    subtitle: "Sin caídas registradas")
            }
            NavigationLink {
                EnvironmentView()
            } label: {
                row(icon: "thermometer.medium",
                    title: "Ambiente",
                    subtitle: "21.5°C · 45% confortable")
            }
            NavigationLink {
                WaterView()
            } label: {
                row(icon: "drop.fill",
                    title: "Consumo de agua",
                    subtitle: "Sin datos disponibles")
            }
            NavigationLink {
                MedicationView()
            } label: {
                row(icon: "pills.fill",
                    title: "Medicación",
                    subtitle: "Sin pauta configurada")
            }
            NavigationLink {
                PresenceView()
            } label: {
                row(icon: "figure.walk.motion",
                    title: "Actividad y presencia",
                    subtitle: "Sin datos")
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Monitorización")
    }

    private func row(icon: String, title: String, subtitle: String) -> some View {
        HStack(spacing: Spacing.m) {
            ZStack {
                Circle().fill(AppTheme.primaryLight)
                Image(systemName: icon)
                    .foregroundStyle(AppTheme.primary)
                    .font(.system(size: 16, weight: .semibold))
            }
            .frame(width: 36, height: 36)

            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(title)
                    .font(Typography.body)
                Text(subtitle)
                    .font(Typography.footnote)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MonitoringView()
    }
}
