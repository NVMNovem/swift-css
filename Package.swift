// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-css",
    products: [
        .library(name: "SwiftCSS", targets: ["SwiftCSS"]),
    ],
    targets: [
        .target(
            name: "SwiftCSS"
        ),
        .testTarget(
            name: "SwiftCSSTests",
            dependencies: ["SwiftCSS"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
