//
//  CSSColorSchemePreference.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 12/06/2026.
//

public enum CSSColorSchemePreference: Sendable {
    
    case dark
    case light
}

internal extension CSSColorSchemePreference {
    
    var rawValue: String {
        switch self {
        case .dark:
            "dark"
        case .light:
            "light"
        }
    }
}
