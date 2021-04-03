// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XCAudit",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(
            name: "xcaudit",
            targets: ["XCAudit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0"),
    ],
    targets: [
        .target(
            name: "XCAudit",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .target(name: "XCAuditKit")
            ]),
        .target(
            name: "XCAuditKit",
            dependencies: []),
        .testTarget(
            name: "XCAuditKitTests",
            dependencies: ["XCAuditKit"]),
    ]
)
