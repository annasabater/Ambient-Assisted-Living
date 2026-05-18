//
//  WaterView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct WaterView: View {
    var body: some View {
        ContentUnavailableView(
            "Próximamente",
            systemImage: "drop.fill",
            description: Text("El seguimiento del consumo de agua estará disponible en una próxima versión.")
        )
        .navigationTitle("Consumo de agua")
    }
}

#Preview {
    NavigationStack {
        WaterView()
    }
}
