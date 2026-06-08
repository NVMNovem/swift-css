//
//  FlexAlignment.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct FlexWrap: CSSProperty {
    
    public let name = "flex-wrap"
    public let value: String
    
    public init(_ value: FlexWrapValue) {
        self.value = value.rawValue
    }
}

public struct AlignItems: CSSProperty {
    
    public let name = "align-items"
    public let value: String
    
    public init(_ value: AlignItemsValue) {
        self.value = value.rawValue
    }
}

public struct JustifyContent: CSSProperty {
    
    public let name = "justify-content"
    public let value: String
    
    public init(_ value: JustifyContentValue) {
        self.value = value.rawValue
    }
}
