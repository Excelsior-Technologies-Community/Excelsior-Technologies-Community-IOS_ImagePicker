//
//  StoryView.swift
//  StoryView
//
//  Created by Noman belim on 07/12/25.
//
import SwiftUI

public struct StoryView: View {
    let image: UIImage

   public  var body: some View {
        GeometryReader { geo in
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
        }
        .ignoresSafeArea()
    }
}
