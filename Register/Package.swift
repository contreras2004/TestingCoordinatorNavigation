// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Register",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Register",
            targets: ["Register"])
    ],
    dependencies: [
        .package(path: "./Navigation"),
        .package(path: "./Networking"),
        .package(path: "./UI"),
        .package(path: "./TestUtils"),
        .package(url: "https://github.com/Quick/Quick.git",
                 .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/Quick/Nimble.git",
                 .upToNextMajor(from: "10.0.0")),
        .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", from: "6.6.0"),
        .package(url: "https://github.com/ashfurrow/Nimble-Snapshots", from: "9.4.0")
    ],
    targets: [
        .target(
            name: "Register",
            dependencies: [
                .product(name: "Navigation", package: "Navigation"),
                .product(name: "Networking", package: "Networking"),
                .product(name: "UI", package: "UI")
            ],
            plugins: [
                .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
            ]
        ),
        .testTarget(
            name: "RegisterTests",
            dependencies: [
                "Register",
                "Quick",
                "Nimble",
                "Nimble-Snapshots",
                "TestUtils",
                "Networking"
            ]
        )
    ]
)
