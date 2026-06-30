//
//  Positioning.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct Top: CSSProperty {
    
    public let name = "top"
    public let value: String
    
    public init(_ value: Length) {
        self.value = value.rawValue
    }
    
    public init(_ value: Percentage) {
        self.value = value.rawValue
    }
    
    public init(_ value: String) {
        self.value = value
    }
}

public struct Right: CSSProperty {
    
    public let name = "right"
    public let value: String
    
    public init(_ value: Length) {
        self.value = value.rawValue
    }
    
    public init(_ value: Percentage) {
        self.value = value.rawValue
    }
    
    public init(_ value: String) {
        self.value = value
    }
}

public struct Bottom: CSSProperty {
    
    public let name = "bottom"
    public let value: String
    
    public init(_ value: Length) {
        self.value = value.rawValue
    }
    
    public init(_ value: Percentage) {
        self.value = value.rawValue
    }
    
    public init(_ value: String) {
        self.value = value
    }
}

public struct Left: CSSProperty {
    
    public let name = "left"
    public let value: String
    
    public init(_ value: Length) {
        self.value = value.rawValue
    }
    
    public init(_ value: Percentage) {
        self.value = value.rawValue
    }
    
    public init(_ value: String) {
        self.value = value
    }
}

public struct Inset: CSSProperty {
    
    public let name = "inset"
    public let value: String
    
    public init(_ value: Length) {
        self.value = value.rawValue
    }
    
    public init(_ value: Percentage) {
        self.value = value.rawValue
    }
    
    public init(_ value: String) {
        self.value = value
    }
}

public struct ZIndex: CSSProperty {
    
    public let name = "z-index"
    public let value: String
    
    public init(_ value: Int) {
        self.value = "\(value)"
    }
    
    public init(_ value: String) {
        self.value = value
    }
}
