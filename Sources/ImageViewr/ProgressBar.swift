//
//  ProgressBar.swift
//  StoryView
//
//  Created by Noman belim on 07/12/25.
//

import SwiftUI
import SwiftUI

public  struct ProgressBar: View {
    let numberOfSegments: Int
    let currentIndex: Int
    let progress: Double

    public  var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<numberOfSegments, id: \.self) { index in
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Rectangle().foregroundColor(.white.opacity(0.3))
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: geo.size.width * segmentProgress(index))
                    }
                    .cornerRadius(2)
                }
            }
        }
        .frame(height: 2)
        .padding(.horizontal, 8)
    }

    private func segmentProgress(_ index: Int) -> Double {
        if index < currentIndex { return 1 }
        if index == currentIndex { return progress }
        return 0
    }
}

