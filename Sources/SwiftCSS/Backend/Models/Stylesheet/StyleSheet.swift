//
//  StyleSheet.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct StyleSheet: CSSRenderable {

    public let cssNode: CSSNode
    
    public init(
        @CSSBuilder rules: () -> [CSSNode]
    ) {
        self.cssNode = .stylesheet(.init(children: rules()))
    }
}
