// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Theme",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Theme",
            targets: ["Theme"])
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git",
                 .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/Quick/Nimble.git",
                 .upToNextMajor(from: "10.0.0")),
        .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", from: "6.6.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Theme",
            dependencies: [],
            plugins: [
                .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
            ]
        ),
        .testTarget(
            name: "ThemeTests",
            dependencies: [
                "Theme",
                "Quick",
                "Nimble"
            ])
    ]
)
