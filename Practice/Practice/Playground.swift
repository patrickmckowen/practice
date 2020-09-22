//
//  Playground.swift
//  Practice
//
//  Created by Patrick McKowen on 9/22/20.
//

import SwiftUI

struct Playground: View {
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            Button("Log Session") { }
                .buttonStyle(ButtonLight())
            Button("Cancel") { }
                .buttonStyle(ButtonLight())
                .padding(.bottom, 32)
        }
        .background(Image("default")).edgesIgnoringSafeArea(.all)
    }
}



struct Playground_Previews: PreviewProvider {
    static var previews: some View {
        Playground()
    }
}
