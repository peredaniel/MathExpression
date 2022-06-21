// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "MathExpression",
    products: [
        .library(name: "MathExpression", targets: ["MathExpression"]),
    ],
    targets: [
        .target(name: "MathExpression", path: "MathExpression/Source"),
    ]
)