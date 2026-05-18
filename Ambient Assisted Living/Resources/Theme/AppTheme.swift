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
    static let s: CGFloat = 8
    static let m: CGFloat = 16
    static let l: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
}

enum Radius {
    static let s: CGFloat = 8
    static let m: CGFloat = 12
    static let l: CGFloat = 16
    static let xl: CGFloat = 24
}
