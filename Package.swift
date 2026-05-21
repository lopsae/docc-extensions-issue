// swift-tools-version: 6.3


import PackageDescription


let package = Package(
    name: "DoccExtensionsIssue",
    platforms: [
        .iOS(.v26),
        .macOS(.v26)
    ],
    products: [
        .library(
            name: "DoccExtensionsIssue",
            targets: ["DoccExtensionsIssue"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.1.0")
    ],
    targets: [
        .target(
            name: "DoccExtensionsIssue",
            path: "sources",
        )
    ]
)
