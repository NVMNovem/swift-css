//
//  CSSRendererProtocol.swift
//  swift-css
//
//  Created by Damian Van de Kauter on 06/07/2026.
//

public protocol CSSRendererProtocol {
    
    associatedtype Output
    
    func render(_ stylesheet: StyleSheet) -> Output
    func render(_ rule: Rule) -> Output
}
