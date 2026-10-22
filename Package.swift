// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-iso-13616",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "ISO 13616", targets: ["ISO 13616"])
    ],
    dependencies: [
        .package(url: "https://github.com/swift-iso/swift-iso-7064.git", branch: "main")
    ],
    targets: [
        .target(
            name: "ISO 13616",
            dependencies: [
                .product(name: "ISO 7064", package: "swift-iso-7064")
            ]
        ),
        .testTarget(
            name: "ISO 13616 Tests",
            dependencies: [
                .target(name: "ISO 13616")
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    target.swiftSettings =
        (target.swiftSettings ?? []) + [
            .strictMemorySafety(),
            .enableUpcomingFeature("ExistentialAny"),
            .enableUpcomingFeature("InternalImportsByDefault"),
            .enableUpcomingFeature("MemberImportVisibility"),
            .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
            .enableUpcomingFeature("InferIsolatedConformances"),
            .enableExperimentalFeature("Lifetimes"),
            .treatAllWarnings(as: .error),
        ]
}
