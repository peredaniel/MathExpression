// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "MathExpression",
    platforms: [
        .macOS(.v10_14), .iOS(.v12), .tvOS(.v12)
    ],
    products: [
        .library(name: "MathExpression", targets: ["MathExpression"]),
    ],
    targets: [
        .target(name: "MathExpression", path: "MathExpression/Source"),
    ]
)
