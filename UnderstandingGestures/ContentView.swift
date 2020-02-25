//
//  ContentView.swift
//  UnderstandingGestures
//
//  Created by Ramill Ibragimov on 25.02.2020.
//  Copyright © 2020 Ramill Ibragimov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isPressed = false
    @GestureState private var longPressTap = false
    
    // Using Drag Gesture
    @GestureState private var dragOffset = CGSize.zero
    @State private var position = CGSize.zero
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("Long press gesture")
            Image(systemName: "star.circle.fill")
                .font(.system(size: 50))
                .scaleEffect(isPressed ? 0.5 : 1.0)
                .animation(.easeInOut)
                .foregroundColor(.green)
                .gesture(
                    LongPressGesture(minimumDuration: 1.0)
                        .onEnded({ _ in
                            self.isPressed.toggle()
                })
            )
            
            Image(systemName: "star.circle.fill")
                .font(.system(size: 50))
                .opacity(longPressTap ? 0.4 : 1.0)
                .scaleEffect(isPressed ? 0.5 : 1.0)
                .animation(.easeInOut)
                .foregroundColor(.orange)
                .gesture(
                    LongPressGesture(minimumDuration: 1.0)
                        .updating($longPressTap, body: { (currentState, state, transaction) in
                            state = currentState
                })
                .onEnded({ _ in
                    self.isPressed.toggle()
                    
                })
            )
            
            // Using Drag Gesture
            Text("Using Drag Gesture")
            Image(systemName: "star.circle.fill")
                .font(.system(size: 50))
                .offset(x: position.width + dragOffset.width,
                        y: position.height + dragOffset.height)
                .animation(.easeInOut)
                .foregroundColor(.yellow)
                .gesture(
                    DragGesture()
                        .updating($dragOffset, body: { (value, state, transaction) in
                            state = value.translation
                        })
                    .onEnded({ (value) in
                        self.position.height += value.translation.height
                        self.position.width += value.translation.width
                    })
                )
    
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
