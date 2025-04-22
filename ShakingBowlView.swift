//
//  ShakingBowlView.swift
//  Final Project
//
//  Created by Aniqa Ali on 4/19/25.
//

import SwiftUI

struct ShakingBowlView: View {
    @State private var shake = false

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.yellow.opacity(0.3),Color.orange.opacity(0.4)], startPoint: .top, endPoint:.bottom)
                .ignoresSafeArea()
            VStack{
                
                Image("salad bowl 2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .offset(x: shake ? -8 : 8)
                    .animation(
                        Animation.easeInOut(duration: 0.1)
                            .repeatCount(6, autoreverses: true) // Shake back/forth 3 times
                            .delay(1.0), // Delay before starting again
                        value: shake
                    )
                FadingTextView()
             
                    
                
            }

        }
        .onAppear {
            // Loop shake with pause using a repeating timer
            Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { _ in
                shake.toggle()
            }
        }
        
    }
}
