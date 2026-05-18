//
//  ControlView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct ControlView: View {
    var body: some View {
        VStack(spacing: 16) {
            ContentUnavailableView(
                "Sin dispositivos vinculados",
                systemImage: "lightbulb.slash",
                description: Text("Empareja un dispositivo para empezar a controlar luces y válvulas")
            )

            Button(action: {}) {
                Label("Añadir dispositivo", systemImage: "plus.circle.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
        }
        .padding(.bottom)
        .navigationTitle("Control")
    }
}

#Preview {
    NavigationStack {
        ControlView()
    }
}
