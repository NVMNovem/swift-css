//
//  StyleSheet.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct StyleSheet: CSSRenderable {
    
    public let rules: [any CSSRenderable]
    
    public init(
        @CSSBuilder rules: () -> [any CSSRenderable]
    ) {
        self.rules = rules()
    }
}
