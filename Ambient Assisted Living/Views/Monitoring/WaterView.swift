//
//  WaterView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct WaterView: View {
    var body: some View {
        ContentUnavailableView(
            "Sin datos de consumo",
            systemImage: "drop.degreesign",
            description: Text("Empareja un sensor de agua para empezar a medir el consumo diario.")
        )
        .navigationTitle("Consumo de agua")
    }
}

#Preview {
    NavigationStack {
        WaterView()
    }
}
