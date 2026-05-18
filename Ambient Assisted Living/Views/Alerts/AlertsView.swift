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
            description: Text("Cuando haya alertas activas aparecerán aquí.")
        )
        .navigationTitle("Alertas")
    }
}

#Preview {
    NavigationStack {
        AlertsView()
    }
}
