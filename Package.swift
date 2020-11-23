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
        .library(
            name: "XCAuditKit",
            targets: ["XCAuditKit"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "XCAudit",
            dependencies: ["XCAuditKit"]),
        .target(
            name: "XCAuditKit",
            dependencies: []),
        .testTarget(
            name: "XCAuditKitTests",
            dependencies: ["XCAuditKit"]),
    ]
)
