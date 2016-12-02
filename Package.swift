import PackageDescription

let package = Package(
    name: "Reflection+Extensions",
    dependencies: [
        .Package(url: "https://github.com/Zewo/Reflection.git", majorVersion: 0)
    ]
)
