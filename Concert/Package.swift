// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Concert",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Concert",
            targets: ["Concert"]),
    ],
    dependencies: [
        .package(path: "../Platform"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "Concert",
            dependencies: [
                .product(name: "AppUtil", package: "Platform"),
                .product(name: "Networks", package: "Platform"),
                .product(name: "Kingfisher", package: "Kingfisher"),
            ]
        ),
    ]
)
