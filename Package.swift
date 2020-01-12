// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SomeCollection",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(
            name: "SomeCollection",
            targets: ["SomeCollection"]
        ),
        .library(
            name: "MakeSomeCollectionLib",
            targets: ["MakeSomeCollectionLib"]
        ),
        .executable(
            name: "MakeSomeCollection",
            targets: ["MakeSomeCollection"]
        )
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SomeCollection",
            dependencies: [],
            path: "Sources/SomeCollection"
        ),
        .target(
            name: "MakeSomeCollectionLib",
            dependencies: [],
            path: "Sources/MakeSomeCollectionLib"
        ),
        .testTarget(
            name: "MakeSomeCollectionLibTests",
            dependencies: ["MakeSomeCollectionLib"]
        ),
        .target(
            name: "MakeSomeCollection",
            dependencies: ["MakeSomeCollectionLib"],
            path: "Sources/MakeSomeCollection"
        ),
    ]
)
