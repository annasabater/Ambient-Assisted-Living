//
//  MedicationView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct MedicationView: View {
    var body: some View {
        ContentUnavailableView(
            label: {
                Label("Sin pauta de medicación", systemImage: "pills.circle")
            },
            description: {
                Text("Configura una pauta para recibir recordatorios y hacer seguimiento de las tomas.")
            },
            actions: {
                Button("Añadir pauta") {}
                    .buttonStyle(PrimaryButtonStyle())
                    .padding(.horizontal, Spacing.xl)
            }
        )
        .navigationTitle("Medicación")
    }
}

#Preview {
    NavigationStack {
        MedicationView()
    }
}
