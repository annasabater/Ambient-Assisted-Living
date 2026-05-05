//
//  ContentView.swift
//  Ambient Assisted Living
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart.text.square.fill")
                .font(.system(size: 64))
                .foregroundStyle(.tint)
            Text("Ambient Assisted Living")
                .font(.title2.bold())
            Text("SwiftUI scaffold ready")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
