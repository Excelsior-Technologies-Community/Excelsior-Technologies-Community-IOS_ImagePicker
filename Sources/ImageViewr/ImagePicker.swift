//
//  ImagePicker.swift
//  StoryView
//
//  Created by Noman belim on 07/12/25.
//
import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var images: [UIImage]

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) { self.parent = parent }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            results.forEach { item in
                if item.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    item.itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                        if let img = image as? UIImage {
                            DispatchQueue.main.async { self.parent.images.append(img) }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Story Model
struct Story: Identifiable {
    let id = UUID()
    let image: UIImage
    let duration: Double = 5.0
}

