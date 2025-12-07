// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "ExcelsiorTechnologiesImagePicker",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "ExcelsiorTechnologiesImagePicker",
            targets: ["ExcelsiorTechnologiesImagePicker"]
        )
    ],
    targets: [
        .target(
            name: "ExcelsiorTechnologiesImagePicker",
            path: "Sources/ExcelsiorTechnologiesImagePicker"
        ),
        .testTarget(
            name: "ExcelsiorTechnologiesImagePickerTests",
            dependencies: ["ExcelsiorTechnologiesImagePicker"],
            path: "Tests"
        )
    ]
)
