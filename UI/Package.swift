// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UI",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "UI",
            targets: ["UI"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(path: "./Theme"),
        .package(path: "./TestUtils"),
        .package(url: "https://github.com/Quick/Quick.git",
                 .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/Quick/Nimble.git",
                 .upToNextMajor(from: "10.0.0")),
        .package(url: "https://github.com/ashfurrow/Nimble-Snapshots", from: "9.4.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "UI",
            dependencies: [
                .product(name: "Theme", package: "Theme")
            ]),
        .testTarget(
            name: "UITests",
            dependencies: [
                "UI",
                "TestUtils",
                "Quick",
                "Nimble",
                "Nimble-Snapshots"
            ])
    ]
)
