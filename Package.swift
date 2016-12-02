import PackageDescription

let package = Package(
    name: "ReflectionExtensions",
    dependencies: [
        .Package(url: "https://github.com/Zewo/Reflection.git", majorVersion: 0)
    ]
)
