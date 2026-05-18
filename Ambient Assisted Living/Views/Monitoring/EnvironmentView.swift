//
//  EnvironmentView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct EnvironmentView: View {
    enum TimeRange: Hashable {
        case day24h
        case week
        case month
    }

    @State private var selectedRange: TimeRange = .day24h
    @State private var currentTemp: Double = 21.5
    @State private var currentHumidity: Double = 45.0
    @State private var lastReading: Date = Date().addingTimeInterval(-180)
    @State private var deviceName: String = "Salón"

    private var tempStatus: EnvironmentStatus {
        EnvironmentRange.evaluateTemperature(currentTemp)
    }

    private var humidityStatus: EnvironmentStatus {
        EnvironmentRange.evaluateHumidity(currentHumidity)
    }

    private var combinedStatus: EnvironmentStatus {
        EnvironmentRange.combined(tempStatus, humidityStatus)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.l) {
                HStack(spacing: Spacing.m) {
                    EnvironmentCard(
                        title: "Temperatura",
                        value: String(format: "%.1f", currentTemp),
                        unit: "°C",
                        icon: "thermometer",
                        statusColor: tempStatus.color
                    )
                    EnvironmentCard(
                        title: "Humedad",
                        value: String(format: "%.0f", currentHumidity),
                        unit: "%",
                        icon: "humidity.fill",
                        statusColor: humidityStatus.color
                    )
                }

                HStack {
                    StatusBadge(text: combinedStatus.label, color: combinedStatus.color)
                    Spacer()
                    Text("Hace 3 minutos")
                        .font(Typography.footnote)
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, Spacing.xs)

                rangeCard
                summaryCard
                lastReadingCard
                alertsLink
            }
            .padding(.horizontal, Spacing.l)
            .padding(.vertical, Spacing.m)
        }
        .background(AppTheme.background.ignoresSafeArea())
        .navigationTitle("Ambiente")
    }

    private var rangeCard: some View {
        VStack(alignment: .leading, spacing: Spacing.m) {
            Picker("Rango", selection: $selectedRange) {
                Text("24 horas").tag(TimeRange.day24h)
                Text("7 días").tag(TimeRange.week)
                Text("30 días").tag(TimeRange.month)
            }
            .pickerStyle(.segmented)

            VStack(spacing: Spacing.s) {
                Image(systemName: "chart.xyaxis.line")
                    .font(.system(size: 36))
                    .foregroundStyle(.tertiary)
                Text("Gráfico próximamente")
                    .font(Typography.footnote)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 160)
            .background(AppTheme.background)
            .clipShape(RoundedRectangle(cornerRadius: Radius.m, style: .continuous))
        }
        .padding(Spacing.m)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: Radius.l, style: .continuous))
    }

    private var summaryCard: some View {
        VStack(alignment: .leading, spacing: Spacing.m) {
            Text("Promedios")
                .font(Typography.headline)

            HStack {
                statColumn(label: "Mín", value: "18.2°", color: AppTheme.primary)
                Divider().frame(height: 40)
                statColumn(label: "Media", value: "21.5°", color: AppTheme.primary)
                Divider().frame(height: 40)
                statColumn(label: "Máx", value: "24.8°", color: AppTheme.warning)
            }
        }
        .padding(Spacing.m)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: Radius.l, style: .continuous))
    }

    private var lastReadingCard: some View {
        HStack(spacing: Spacing.m) {
            ZStack {
                Circle()
                    .fill(AppTheme.primaryLight)
                    .frame(width: 36, height: 36)
                Image(systemName: "sensor.fill")
                    .font(.system(size: 14))
                    .foregroundStyle(AppTheme.primary)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(deviceName)
                    .font(Typography.body)
                    .fontWeight(.medium)
                Text("Hace 3 minutos")
                    .font(Typography.footnote)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(Spacing.m)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.surface)
        .clipShape(RoundedRectangle(cornerRadius: Radius.l, style: .continuous))
    }

    private var alertsLink: some View {
        NavigationLink(destination: EmptyView()) {
            HStack {
                Image(systemName: "bell.badge")
                    .foregroundStyle(AppTheme.primary)
                Text("Configurar umbrales de alerta")
                    .font(Typography.body)
                    .foregroundStyle(.primary)
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
    private func statColumn(label: String, value: String, color: Color) -> some View {
        VStack(spacing: Spacing.xs) {
            Text(label)
                .font(Typography.footnote)
                .foregroundStyle(.secondary)
            Text(value)
                .font(Typography.title)
                .foregroundStyle(color)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    NavigationStack {
        EnvironmentView()
    }
}
