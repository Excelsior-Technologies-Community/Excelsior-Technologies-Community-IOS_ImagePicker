// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ImageViewr",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "ImageViewr",
            targets: ["ImageViewr"]
        ),
    ],
    targets: [
        .target(
            name: "ImageViewr",
            path: "Sources/ImageViewr"
        ),
        .testTarget(
            name: "ImageViewrTests",
            dependencies: ["ImageViewr"],
            path: "Tests"
        )
    ]
)
