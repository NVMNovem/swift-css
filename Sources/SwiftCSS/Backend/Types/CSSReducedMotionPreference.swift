//
//  CSSReducedMotionPreference.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 12/06/2026.
//

public enum CSSReducedMotionPreference: Sendable {
    
    case reduce
    case noPreference
}

internal extension CSSReducedMotionPreference {
    
    var rawValue: String {
        switch self {
        case .reduce:
            "reduce"
        case .noPreference:
            "no-preference"
        }
    }
}
