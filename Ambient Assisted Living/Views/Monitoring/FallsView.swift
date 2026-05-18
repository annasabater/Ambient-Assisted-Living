//
//  FallsView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct FallsView: View {
    var body: some View {
        ContentUnavailableView(
            "Próximamente",
            systemImage: "figure.fall",
            description: Text("La detección de caídas estará disponible en una próxima versión.")
        )
        .navigationTitle("Detección de caídas")
    }
}

#Preview {
    NavigationStack {
        FallsView()
    }
}
