//
//  ControlView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct ControlView: View {
    var body: some View {
        ContentUnavailableView(
            label: {
                Label("Sin dispositivos vinculados", systemImage: "lightbulb.slash")
            },
            description: {
                Text("Empareja un dispositivo para empezar a controlar luces, válvulas y otros elementos del hogar.")
            },
            actions: {
                Button("Añadir dispositivo") {}
                    .buttonStyle(PrimaryButtonStyle())
                    .padding(.horizontal, Spacing.xl)
            }
        )
        .navigationTitle("Control")
    }
}

#Preview {
    NavigationStack {
        ControlView()
    }
}
