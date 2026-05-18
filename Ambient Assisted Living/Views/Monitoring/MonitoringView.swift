//
//  MonitoringView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct MonitoringView: View {
    private struct Item: Identifiable {
        let id = UUID()
        let icon: String
        let title: String
        let subtitle: String
    }

    private let items: [Item] = [
        Item(icon: "figure.fall", title: "Detección de caídas", subtitle: "Sin caídas registradas"),
        Item(icon: "drop.fill", title: "Consumo de agua", subtitle: "Sin datos disponibles"),
        Item(icon: "pills.fill", title: "Medicación", subtitle: "Sin pauta configurada"),
        Item(icon: "figure.walk.motion", title: "Actividad y presencia", subtitle: "Sin datos")
    ]

    var body: some View {
        List {
            NavigationLink {
                FallsView()
            } label: {
                row(icon: items[0].icon, title: items[0].title, subtitle: items[0].subtitle)
            }
            NavigationLink {
                WaterView()
            } label: {
                row(icon: items[1].icon, title: items[1].title, subtitle: items[1].subtitle)
            }
            NavigationLink {
                MedicationView()
            } label: {
                row(icon: items[2].icon, title: items[2].title, subtitle: items[2].subtitle)
            }
            NavigationLink {
                PresenceView()
            } label: {
                row(icon: items[3].icon, title: items[3].title, subtitle: items[3].subtitle)
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
                    .font(.system(size: 18, weight: .semibold))
            }
            .frame(width: 44, height: 44)

            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(title)
                    .font(.body)
                    .fontWeight(.semibold)
                Text(subtitle)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        MonitoringView()
    }
}
