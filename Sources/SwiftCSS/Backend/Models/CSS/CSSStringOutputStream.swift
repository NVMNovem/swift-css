//
//  CSSStringOutputStream.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 07/06/2026.
//

public final class CSSStringOutputStream: CSSOutputStream {
    
    public private(set) var output: String
    
    public init(output: String = "") {
        self.output = output
    }
    
    public func write(_ string: String) {
        output += string
    }
    
}
