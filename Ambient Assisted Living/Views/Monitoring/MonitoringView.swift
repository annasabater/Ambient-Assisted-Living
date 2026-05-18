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
                Label("Detección de caídas", systemImage: "figure.fall")
            }

            NavigationLink {
                WaterView()
            } label: {
                Label("Consumo de agua", systemImage: "drop.fill")
            }

            NavigationLink {
                MedicationView()
            } label: {
                Label("Medicación", systemImage: "pills.fill")
            }

            NavigationLink {
                PresenceView()
            } label: {
                Label("Actividad y presencia", systemImage: "figure.walk")
            }
        }
        .navigationTitle("Monitorización")
    }
}

#Preview {
    NavigationStack {
        MonitoringView()
    }
}
