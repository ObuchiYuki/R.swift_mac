// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Rswift_mac",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "Rswift_mac", targets: ["Rswift_mac"]),
    ],
    dependencies: [
        .package(url: "https://github.com/mac-cain13/R.swift.git", from: "7.0.0"),
    ],
    targets: [
        .target(
            name: "Rswift_mac",
            dependencies: [.product(name: "RswiftLibrary", package: "R.swift")]
        ),
        .testTarget(name: "Rswift_mac_Tests", dependencies: ["Rswift_mac"]),
    ]
)
