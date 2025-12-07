//
//  ContentView.swift
//  StoryView
//
//  Created by Noman belim on 07/12/25.
import SwiftUI

struct ContentView: View {
    @State private var showPicker = false
    @State private var showViewer = false
    @State private var images: [UIImage] = []

    var body: some View {
        VStack(spacing: 20) {

            Button("Select Images") {
                showPicker = true
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .cornerRadius(12)

            if !images.isEmpty {
                Button("View Stories") {
                    showViewer = true
                }
                .padding()
                .background(.green)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
        }
        .sheet(isPresented: $showPicker) {
            ImagePicker(images: $images)
        }
        .fullScreenCover(isPresented: $showViewer) {
            StoryViewer(images: images)
        }
    }
}
