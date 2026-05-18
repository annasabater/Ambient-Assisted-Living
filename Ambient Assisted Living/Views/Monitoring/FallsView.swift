//
//  FallsView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct FallsView: View {
    var body: some View {
        ContentUnavailableView(
            "Sin caídas registradas",
            systemImage: "figure.fall.circle",
            description: Text("Cuando el sistema detecte una caída, aparecerá aquí con detalles del momento y la ubicación.")
        )
        .navigationTitle("Detección de caídas")
    }
}

#Preview {
    NavigationStack {
        FallsView()
    }
}
