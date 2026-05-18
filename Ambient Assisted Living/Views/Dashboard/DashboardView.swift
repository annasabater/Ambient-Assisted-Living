//
//  DashboardView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var authService: AuthService

    private struct Metric: Identifiable {
        let id = UUID()
        let label: String
        let value: String
        let icon: String
        let color: Color
    }

    private var metrics: [Metric] {
        [
            Metric(label: "Consumo de agua", value: "2.1 L", icon: "drop.fill", color: AppTheme.primary),
            Metric(label: "Medicación", value: "2 de 3", icon: "pills.fill", color: AppTheme.warning),
            Metric(label: "Actividad", value: "4h 12min", icon: "figure.walk", color: AppTheme.primary),
            Metric(label: "Caídas", value: "Sin incidentes", icon: "checkmark.shield", color: AppTheme.success)
        ]
    }

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
            VStack(spacing: Spacing.m) {
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text(greeting)
                        .font(Typography.title)
                    Text(formattedDate)
                        .font(Typography.footnote)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                statusCard
                environmentCard
                metricsCard
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
                    .font(Typography.footnote)
                    .foregroundStyle(.secondary)
                HStack(spacing: Spacing.s) {
                    Circle()
                        .fill(AppTheme.success)
                        .frame(width: 10, height: 10)
                    Text("Todo en orden")
                        .font(Typography.headline)
                }
                Text("Última actividad detectada hace 3 minutos")
                    .font(Typography.footnote)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "checkmark.shield.fill")
                .font(.system(size: 26))
                .foregroundStyle(AppTheme.success)
        }
        .padding(Spacing.m)
        .background(AppTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: Radius.l, style: .continuous))
    }

    private var environmentCard: some View {
        NavigationLink(destination: EnvironmentView()) {
            HStack(alignment: .top, spacing: Spacing.m) {
                VStack(alignment: .leading, spacing: Spacing.s) {
                    Text("Ambiente del hogar")
                        .font(Typography.footnote)
                        .foregroundStyle(.secondary)

                    HStack(spacing: Spacing.l) {
                        dashEnvMetric(icon: "thermometer", value: "21.5°", color: AppTheme.success)
                        dashEnvMetric(icon: "humidity.fill", value: "45%", color: AppTheme.success)
                    }

                    StatusBadge(text: "Confortable", color: AppTheme.success)
                        .padding(.top, Spacing.xs)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(Typography.footnote)
                    .foregroundStyle(.tertiary)
            }
            .padding(Spacing.m)
            .background(AppTheme.surface)
            .clipShape(RoundedRectangle(cornerRadius: Radius.l, style: .continuous))
        }
        .buttonStyle(.plain)
    }

    @ViewBuilder
    private func dashEnvMetric(icon: String, value: String, color: Color) -> some View {
        HStack(spacing: Spacing.xs) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundStyle(color)
            Text(value)
                .font(Typography.title)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
        }
    }

    private var metricsCard: some View {
        VStack(spacing: 0) {
            ForEach(Array(metrics.enumerated()), id: \.element.id) { index, metric in
                metricRow(metric)
                if index < metrics.count - 1 {
                    Divider()
                        .padding(.leading, 34 + Spacing.m)
                }
            }
        }
        .padding(.vertical, Spacing.s)
        .padding(.horizontal, Spacing.m)
        .background(AppTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: Radius.l, style: .continuous))
    }

    private func metricRow(_ metric: Metric) -> some View {
        HStack(spacing: Spacing.m) {
            ZStack {
                Circle()
                    .fill(AppTheme.primaryLight)
                    .frame(width: 34, height: 34)
                Image(systemName: metric.icon)
                    .font(.system(size: 14))
                    .foregroundStyle(metric.color)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(metric.label)
                    .font(Typography.footnote)
                    .foregroundStyle(.secondary)
                Text(metric.value)
                    .font(Typography.body)
                    .fontWeight(.medium)
            }
            Spacer()
        }
        .padding(.vertical, Spacing.xs)
    }
}

#Preview {
    NavigationStack {
        DashboardView()
            .environmentObject(AuthService())
    }
}
