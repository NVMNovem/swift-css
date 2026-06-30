//
//  Margin.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public struct Margin: CSSProperty {
    
    public let name = "margin"
    public let value: String
    
    public init(_ value: Length) {
        self.value = value.rawValue
    }
}

public struct MarginTop: CSSProperty {
    
    public let name = "margin-top"
    public let value: String
    
    public init(_ value: Length) {
        self.value = value.rawValue
    }
    
    public init(_ value: String) {
        self.value = value
    }
}

public struct MarginBottom: CSSProperty {
    
    public let name = "margin-bottom"
    public let value: String
    
    public init(_ value: Length) {
        self.value = value.rawValue
    }
    
    public init(_ value: String) {
        self.value = value
    }
}

public struct MarginLeft: CSSProperty {
    
    public let name = "margin-left"
    public let value: String
    
    public init(_ value: Length) {
        self.value = value.rawValue
    }
    
    public init(_ value: String) {
        self.value = value
    }
}

public struct MarginRight: CSSProperty {
    
    public let name = "margin-right"
    public let value: String
    
    public init(_ value: Length) {
        self.value = value.rawValue
    }
    
    public init(_ value: String) {
        self.value = value
    }
}
