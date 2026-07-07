// swift-tools-version:6.1

import PackageDescription

let package = Package(
    name: "OtusUI",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "OtusUI", targets: ["OtusUI"])
    ],
    targets: [
        .target(name: "OtusUI")
    ]
)
