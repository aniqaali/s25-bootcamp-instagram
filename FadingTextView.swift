//
//  FadingTextView.swift
//  Final Project
//
//  Created by Aniqa Ali on 4/19/25.
//

// FadingTextView.swift
import SwiftUI

struct FadingTextView: View {
    @State private var showFirstText = true
    @State private var fade = false

    let text1 = "Mealify"
    let text2 = "Meals Made Easy"

    var body: some View {
        ZStack {
            Text(text1)
                .font(.largeTitle)
                .opacity(showFirstText && !fade ? 1 : 0)

            Text(text2)
                .font(.title2)
                .opacity(!showFirstText && !fade ? 1 : 0)
        }
        .animation(.easeInOut(duration: 1), value: fade)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
                fade = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showFirstText.toggle()
                    fade = false
                }
            }
        }
    }
}


#Preview {
    FadingTextView()
}
