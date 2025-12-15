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
            targets: ["ImageViewer"]
        ),
    ],
    targets: [
        .target(
            name: "ImageViewer",
            path: "Sources/ImageViewer"
        ),
        .testTarget(
            name: "ExcelsiorTechnologiesImagePickerTests",
            dependencies: ["ImageViewer"],
            path: "Tests"
        )
    ]
)
