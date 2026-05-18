//
//  PresenceView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct PresenceView: View {
    var body: some View {
        ContentUnavailableView(
            "Próximamente",
            systemImage: "figure.walk",
            description: Text("La actividad y presencia estará disponible en una próxima versión.")
        )
        .navigationTitle("Actividad y presencia")
    }
}

#Preview {
    NavigationStack {
        PresenceView()
    }
}
