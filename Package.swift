// swift-tools-version: 6.3


import PackageDescription


let package = Package(
    name: "DoccIssue",
    platforms: [
        .iOS(.v26),
        .macOS(.v26)
    ],
    products: [
        .library(
            name: "DoccIssue",
            targets: ["DoccIssue"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.1.0")
    ],
    targets: [
        .target(
            name: "DoccIssue",
            path: "sources",
        )
    ]
)
