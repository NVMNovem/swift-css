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
