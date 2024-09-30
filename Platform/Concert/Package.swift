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
        .package(path: "../Networks")
    ],
    targets: [
        .target(
            name: "Concert",
            dependencies: [
                .product(name: "AppUtil", package: "Platform"),
                .product(name: "Networks", package: "Networks"),
                
            ]
        ),
    ]
)
