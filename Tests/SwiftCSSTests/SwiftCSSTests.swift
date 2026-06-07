import Testing
@testable import SwiftCSS

@Test func genericCSSDataTypesRenderRawValues() {
    #expect(CSSPercentage.percent(50).rawValue == "50%")
    #expect(CSSLength.px(24).rawValue == "24px")
    #expect(CSSColor.hex("0f1117").rawValue == "#0f1117")
}

@Test func propertySpecificValuesRenderRawValues() {
    #expect(DisplayValue.flex.rawValue == "flex")
    #expect(PositionValue.absolute.rawValue == "absolute")
    #expect(FontWeight.Value.weight(700).rawValue == "700")
    #expect(Color(.white).value == "white")
}

@Test func firstClassPropertiesRenderPrettyCSS() {
    let stylesheet = StyleSheet {
        Rule(.class("card")) {
            Display(.flex)
            Position(.relative)
            Width(.percent(100))
            BackgroundColor(.hex("0f1117"))
            Padding(.px(24))
            FontWeight(.weight(700))
        }
    }
    
    #expect(
        stylesheet.render() == """
        .card {
            display: flex;
            position: relative;
            width: 100%;
            background-color: #0f1117;
            padding: 24px;
            font-weight: 700;
        }
        """
    )
}

@Test func firstClassPropertiesRenderCompactCSS() {
    let stylesheet = StyleSheet {
        Rule(.class("card")) {
            Display(.flex)
            Position(.relative)
            Width(.percent(100))
            BackgroundColor(.hex("0f1117"))
            Padding(.px(24))
            FontWeight(.weight(700))
        }
    }
    
    #expect(
        stylesheet.render(prettyPrinted: false) == ".card {display:flex;position:relative;width:100%;background-color:#0f1117;padding:24px;font-weight:700;}"
    )
}

@Test func selectorPartsRenderSimpleSelectors() {
    #expect(Rule(.class("hero")) { Display(.grid) }.render(prettyPrinted: false) == ".hero {display:grid;}" )
    #expect(Rule(.id("title")) { Display(.grid) }.render(prettyPrinted: false) == "#title {display:grid;}" )
    #expect(Rule(.element("body")) { Display(.grid) }.render(prettyPrinted: false) == "body {display:grid;}" )
    #expect(Rule(.root) { Display(.grid) }.render(prettyPrinted: false) == ":root {display:grid;}" )
    #expect(Rule(.universal) { Display(.grid) }.render(prettyPrinted: false) == "* {display:grid;}" )
}

@Test func selectorPartsRenderCompoundSelectors() {
    #expect(Rule(.class("button"), .class("primary")) { Display(.grid) }.render(prettyPrinted: false) == ".button.primary {display:grid;}" )
    #expect(Rule(.class("button"), .hover) { Display(.grid) }.render(prettyPrinted: false) == ".button:hover {display:grid;}" )
}

@Test func selectorPartsRenderComplexSelectors() {
    #expect(Rule(.class("card"), .descendant(.element("h2"))) { Display(.grid) }.render(prettyPrinted: false) == ".card h2 {display:grid;}" )
    #expect(Rule(.class("nav"), .child(.element("a"))) { Display(.grid) }.render(prettyPrinted: false) == ".nav > a {display:grid;}" )
    #expect(Rule(.element("h2"), .adjacentSibling(.element("p"))) { Display(.grid) }.render(prettyPrinted: false) == "h2 + p {display:grid;}" )
    #expect(Rule(.element("h2"), .generalSibling(.element("p"))) { Display(.grid) }.render(prettyPrinted: false) == "h2 ~ p {display:grid;}" )
}

@Test func ruleListRendersSelectorLists() {
    let rule = Rule.list(
        [
            [.element("h1")],
            [.element("h2")],
            [.element("h3")]
        ]
    ) {
        FontWeight(.weight(700))
    }
    
    #expect(
        rule.render(prettyPrinted: false) == "h1, h2, h3 {font-weight:700;}"
    )
}

