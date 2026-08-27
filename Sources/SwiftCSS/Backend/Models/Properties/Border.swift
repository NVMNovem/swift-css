//
//  Border.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 08/06/2026.
//

public struct Border: CSSProperty {
    
    public let name = "border"
    public let value: String
    
    public init(_ value: String) {
        self.value = value
    }
}

public struct BorderTop: CSSProperty {
    
    public let name = "border-top"
    public let value: String
    
    public init(_ value: String) {
        self.value = value
    }
}

public struct BorderBottom: CSSProperty {
    
    public let name = "border-bottom"
    public let value: String
    
    public init(_ value: String) {
        self.value = value
    }
}

public struct BorderLeft: CSSProperty {
    
    public let name = "border-left"
    public let value: String
    
    public init(_ value: String) {
        self.value = value
    }
}

public struct BorderRight: CSSProperty {
    
    public let name = "border-right"
    public let value: String
    
    public init(_ value: String) {
        self.value = value
    }
}
