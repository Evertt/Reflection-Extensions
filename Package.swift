// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReflectionExtensions",
    products: [
        .library(
            name: "ReflectionExtensions",
            targets: ["ReflectionExtensions"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Evertt/Reflection.git", .revision("4.0"))
    ],
    targets: [
        .target(
            name: "ReflectionExtensions",
            dependencies: ["Reflection"]
        ),
        .testTarget(
            name: "ReflectionExtensionsTests",
            dependencies: ["ReflectionExtensions", "Reflection"]
        ),
    ]
)
