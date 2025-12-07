//
//  StoryViewer.swift
//  StoryView
//
//  Created by Noman belim on 07/12/25.
//

 
import SwiftUI

public struct StoryViewer: View {
    @Environment(\.presentationMode) private var presentationMode


    let stories: [Story]

    @State private var currentIndex = 0
    @State private var progress: Double = 0
    @State private var timer: Timer?
    @State private var isPaused = false
    @State private var dragOffset: CGFloat = 0
    @State private var goingForward = true

   public  init(images: [UIImage]) {
        self.stories = images.map { Story(image: $0) }
    }

   public  var body: some View {
        ZStack {
            ZStack {
                if currentIndex < stories.count {
                    StoryView(image: stories[currentIndex].image)
                        .id(currentIndex)
                        .transition(animationDirection())
                }

                VStack {
                    ProgressBar(numberOfSegments: stories.count,
                                currentIndex: currentIndex,
                                progress: progress)
                        .padding(.top, 50)

                    Spacer()

                    HStack(spacing: 0) {
                        Color.clear
                            .contentShape(Rectangle())
                            .onTapGesture { previous() }
                            .onLongPressGesture(
                                minimumDuration: .infinity,
                                pressing: pressHandler,
                                perform: {}
                            )


                        Color.clear
                            .contentShape(Rectangle())
                            .onTapGesture { next() }
                            .onLongPressGesture(
                                minimumDuration: .infinity,
                                pressing: pressHandler,
                                perform: {}
                            )

                    }
                }
            }
            .offset(y: dragOffset)
            .scaleEffect(1 - abs(dragOffset) / 2000)
            .opacity(1 - Double(abs(dragOffset)) / 400)
            .gesture(dragGesture)
        }
        .background(.black)
        .ignoresSafeArea()
        .onAppear(perform: startTimer)
        .onDisappear(perform: stopTimer)
    }

    // MARK: - Animations
    private func animationDirection() -> AnyTransition {
        .asymmetric(
            insertion: .move(edge: goingForward ? .trailing : .leading),
            removal: .move(edge: goingForward ? .leading : .trailing)
        )
    }

    // MARK: - Timer Logic
    private func startTimer() {
        guard currentIndex < stories.count else { return }

        let duration = stories[currentIndex].duration
        let interval = 0.02
        let increment = interval / duration

        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            if !isPaused {
                progress += increment
                if progress >= 1 { next() }
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func pressHandler(_ pressing: Bool) {
        pressing ? pause() : resume()
    }

    private func pause() { isPaused = true }
    private func resume() { isPaused = false }

    // MARK: - Navigation
    private func next() {
        stopTimer()
        goingForward = true

        if currentIndex < stories.count - 1 {
            withAnimation(.easeInOut(duration: 0.25)) {
                currentIndex += 1
                progress = 0
            }
            startTimer()
        } else {
            presentationMode.wrappedValue.dismiss()

        }
    }

    private func previous() {
        stopTimer()
        goingForward = false

        if progress > 0.1 {
            progress = 0
            startTimer()
        } else if currentIndex > 0 {
            withAnimation(.easeInOut(duration: 0.25)) {
                currentIndex -= 1
                progress = 0
            }
            startTimer()
        } else {
            progress = 0
            startTimer()
        }
    }

    // MARK: - Drag to Dismiss
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                if value.translation.height > 0 {
                    dragOffset = value.translation.height
                    pause()
                }
            }
            .onEnded { _ in
                if dragOffset > 150 {
                    presentationMode.wrappedValue.dismiss()

                } else {
                    withAnimation(.spring()) { dragOffset = 0 }
                    resume()
                }
            }
    }
}
