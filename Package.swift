// swift-tools-version:6.3.2

import PackageDescription

let package = Package(
    name: "Attester",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "Attester", targets: ["Attester"])
    ],
    dependencies: [
        // https://github.com/myfreeweb/SwiftCBOR
        .package(url: "https://github.com/myfreeweb/SwiftCBOR", from: "0.4.6"),
        
        // https://github.com/apple/swift-crypto
        .package(url: "https://github.com/apple/swift-crypto", from: "3.1.0"),
        
        // https://github.com/iansampson/Anchor
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
