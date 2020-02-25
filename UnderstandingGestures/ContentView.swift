//
//  ContentView.swift
//  UnderstandingGestures
//
//  Created by Ramill Ibragimov on 25.02.2020.
//  Copyright © 2020 Ramill Ibragimov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Image(systemName: "star.circle.fill")
            .font(.system(size: 200))
            .foregroundColor(.green)
            .gesture(
                TapGesture()
                    .onEnded({
                        print("Tapped!")
                        
                    }
                )
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
