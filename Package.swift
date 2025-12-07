// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ExcelsiorTechnologiesImagePicker",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "ExcelsiorTechnologiesImagePicker",
            targets: ["ImageViewr"]
        ),
    ],
    targets: [
        .target(
            name: "ImageViewr",
            path: "Sources/ImageViewr"
        ),
        .testTarget(
            name: "ExcelsiorTechnologiesImagePickerTests",
            dependencies: ["ImageViewr"],
            path: "Tests"
        )
    ]
)
