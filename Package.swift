// swift-tools-version:6.2.1

import PackageDescription

let package = Package(
    name: "Attester",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        .library(name: "Attester", targets: ["Attester"])
    ],
    dependencies: [
        .package(url: "https://github.com/myfreeweb/SwiftCBOR", from: "0.4.6"),
        .package(url: "https://github.com/apple/swift-crypto", from: "3.1.0"),
        .package(url: "https://github.com/iansampson/Anchor", branch: "main")
    ],
    targets: [
        .target(
            name: "Attester",
            dependencies: [
                "SwiftCBOR",
                .product(name: "Crypto", package: "swift-crypto"),
                "Anchor"
            ]
        ),
        .testTarget(name: "AttesterTests", dependencies: ["Attester"])
    ]
)
