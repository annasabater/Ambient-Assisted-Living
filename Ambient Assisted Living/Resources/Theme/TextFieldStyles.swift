//
//  TextFieldStyles.swift
//  Ambient Assisted Living
//

import SwiftUI

private struct BrandFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .padding(.horizontal, Spacing.m)
            .padding(.vertical, 14)
            .background(AppTheme.surface)
            .clipShape(RoundedRectangle(cornerRadius: Radius.m, style: .continuous))
    }
}

extension View {
    func brandField() -> some View {
        modifier(BrandFieldModifier())
    }
}
