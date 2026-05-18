//
//  MedicationView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct MedicationView: View {
    var body: some View {
        ContentUnavailableView(
            "Próximamente",
            systemImage: "pills.fill",
            description: Text("La gestión de la medicación estará disponible en una próxima versión.")
        )
        .navigationTitle("Medicación")
    }
}

#Preview {
    NavigationStack {
        MedicationView()
    }
}
