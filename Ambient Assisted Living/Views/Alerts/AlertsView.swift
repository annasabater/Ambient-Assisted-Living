//
//  AlertsView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct AlertsView: View {
    var body: some View {
        ContentUnavailableView(
            "Sin alertas",
            systemImage: "bell.slash",
            description: Text("Las alertas de caídas, medicación olvidada y anomalías en el hogar aparecerán aquí.")
        )
        .navigationTitle("Alertas")
    }
}

#Preview {
    NavigationStack {
        AlertsView()
    }
}
