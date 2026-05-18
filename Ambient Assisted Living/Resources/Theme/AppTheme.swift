//
//  AppTheme.swift
//  Ambient Assisted Living
//

import SwiftUI

enum AppTheme {
    static var primary: Color { Color("BrandPrimary") }
    static var primaryLight: Color { Color("BrandPrimaryLight") }
    static var background: Color { Color(.systemGroupedBackground) }
    static var surface: Color { Color(.secondarySystemGroupedBackground) }
    static var textPrimary: Color { Color.primary }
    static var textSecondary: Color { Color.secondary }
    static var danger: Color { Color("BrandDanger") }
    static var success: Color { Color("BrandSuccess") }
    static var warning: Color { Color("BrandWarning") }
}

enum Spacing {
    static let xs: CGFloat = 4
    static let s: CGFloat = 6
    static let m: CGFloat = 12
    static let l: CGFloat = 18
    static let xl: CGFloat = 24
    static let xxl: CGFloat = 36
}

enum Radius {
    static let s: CGFloat = 6
    static let m: CGFloat = 10
    static let l: CGFloat = 14
    static let xl: CGFloat = 20
}

enum Typography {
    static let displayTitle = Font.system(size: 26, weight: .bold)
    static let title = Font.system(size: 20, weight: .semibold)
    static let headline = Font.system(size: 16, weight: .semibold)
    static let body = Font.system(size: 15, weight: .regular)
    static let callout = Font.system(size: 14, weight: .regular)
    static let footnote = Font.system(size: 12, weight: .regular)
    static let caption = Font.system(size: 11, weight: .regular)
}
