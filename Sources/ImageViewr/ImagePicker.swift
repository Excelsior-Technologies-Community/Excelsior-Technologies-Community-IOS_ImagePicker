//
//  ImagePicker.swift
//  StoryView
//
//  Created by Noman belim on 07/12/25.
//
import SwiftUI
import PhotosUI

public struct ImagePicker: UIViewControllerRepresentable {

    @Binding public var images: [UIImage]

    public init(images: Binding<[UIImage]>) {
        self._images = images
    }

    public func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0   // allow unlimited images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    public func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        public init(_ parent: ImagePicker) {
            self.parent = parent
        }

        public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                        if let img = image as? UIImage {
                            DispatchQueue.main.async {
                                self.parent.images.append(img)
                            }
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

