//
//  ImagePicker.swift
//  StoryView
//
//  Created by Noman belim on 07/12/25.
//
import SwiftUI
import PhotosUI

public struct ImagePicker: UIViewControllerRepresentable {
    @Binding var images: [UIImage]

   public  func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    public   func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    public   func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public   class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) { self.parent = parent }

        public  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
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
public struct Story: Identifiable {
    public   let id = UUID()
    public   let image: UIImage
    public  let duration: Double = 5.0
}

