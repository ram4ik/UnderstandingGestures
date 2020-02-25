//
//  CombiningGestures.swift
//  UnderstandingGestures
//
//  Created by Ramill Ibragimov on 25.02.2020.
//  Copyright © 2020 Ramill Ibragimov. All rights reserved.
//

import SwiftUI

struct CombiningGestures: View {
    // For long press gesture
    @GestureState private var isPressed = false
    
    // For drag gesture
    @GestureState private var dragOffset = CGSize.zero
    @State private var position = CGSize.zero
    
    var body: some View {
        Image(systemName: "paintbrush.fill")
            .font(.system(size: 100))
            .opacity(isPressed ? 0.5 : 1.0)
            .offset(x: position.width + dragOffset.width,
                    y: position.height + dragOffset.height)
            .animation(.easeInOut)
            .foregroundColor(.purple)
            .gesture(
                LongPressGesture(minimumDuration: 1.0)
                    .updating($isPressed, body: { (currentState, state, transaction) in
                        state = currentState })
                    .sequenced(before: DragGesture())
                    .updating($dragOffset, body: { (value, state, transaction) in
                        switch value {
                        case .first(true):
                            print("Tapping")
                        case .second(true, let drag):
                            state = drag?.translation ?? .zero
                        default:
                            break
                        }
            
                    })
                    .onEnded({ (value) in
                        guard case .second(true, let drag?) = value else {
                            return
                        }
                        self.position.height += drag.translation.height
                        self.position.width += drag.translation.width
                        
                    })
                )
            }
        }


struct CombiningGestures_Previews: PreviewProvider {
    static var previews: some View {
        CombiningGestures()
    }
}
