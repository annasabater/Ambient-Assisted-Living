//
//  PresenceView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct PresenceView: View {
    var body: some View {
        ContentUnavailableView(
            "Sin datos de actividad",
            systemImage: "figure.walk.motion",
            description: Text("Empareja un sensor PIR para detectar movimiento en las distintas estancias.")
        )
        .navigationTitle("Actividad y presencia")
    }
}

#Preview {
    NavigationStack {
        PresenceView()
    }
}
