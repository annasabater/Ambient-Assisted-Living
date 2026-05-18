//
//  DashboardView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var authService: AuthService

    private var displayName: String {
        let name = authService.currentUser?.displayName ?? ""
        return name.isEmpty ? (authService.currentUser?.email ?? "") : name
    }

    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        let prefix: String
        switch hour {
        case 6..<12: prefix = "Buenos días"
        case 12..<21: prefix = "Buenas tardes"
        default: prefix = "Buenas noches"
        }
        return "\(prefix), \(displayName)"
    }

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter.string(from: Date()).capitalized
    }

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.l) {
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text(greeting)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(formattedDate)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                statusCard
                summaryCard

                NavigationLink {
                    EmptyView()
                } label: {
                    Text("Ver todos los detalles")
                }
                .buttonStyle(SecondaryButtonStyle())
            }
            .padding(Spacing.l)
        }
        .background(AppTheme.background)
        .navigationTitle("Inicio")
    }

    private var statusCard: some View {
        HStack {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text("Estado actual")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                HStack(spacing: Spacing.s) {
                    Circle()
                        .fill(AppTheme.success)
                        .frame(width: 12, height: 12)
                    Text("Todo en orden")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                Text("Última actividad detectada hace 3 minutos")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "checkmark.shield.fill")
                .font(.system(size: 32))
                .foregroundStyle(AppTheme.success)
        }
        .padding(Spacing.l)
        .background(AppTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: Radius.l, style: .continuous))
    }

    private var summaryCard: some View {
        VStack(alignment: .leading, spacing: Spacing.m) {
            Text("Resumen del día")
                .font(.headline)

            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: Spacing.m),
                    GridItem(.flexible(), spacing: Spacing.m)
                ],
                spacing: Spacing.m
            ) {
                metricTile(
                    title: "Consumo agua",
                    value: "2.1 L",
                    icon: "drop.fill",
                    color: AppTheme.primary
                )
                metricTile(
                    title: "Pastillas tomadas",
                    value: "2 de 3",
                    icon: "pills.fill",
                    color: AppTheme.warning
                )
                metricTile(
                    title: "Tiempo activo",
                    value: "4h 12min",
                    icon: "figure.walk",
                    color: AppTheme.primary
                )
                metricTile(
                    title: "Última caída",
                    value: "Sin caídas",
                    icon: "figure.fall",
                    color: AppTheme.success
                )
            }
        }
        .padding(Spacing.l)
        .background(AppTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: Radius.l, style: .continuous))
    }

    private func metricTile(title: String, value: String, icon: String, color: Color) -> some View {
        VStack(alignment: .leading, spacing: Spacing.s) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(color)
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
            Text(title)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.m)
        .background(AppTheme.primaryLight)
        .clipShape(RoundedRectangle(cornerRadius: Radius.m, style: .continuous))
    }
}

#Preview {
    NavigationStack {
        DashboardView()
            .environmentObject(AuthService())
    }
}
