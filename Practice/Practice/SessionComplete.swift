//
//  SessionComplete.swift
//  Practice
//
//  Created by Patrick McKowen on 9/17/20.
//

import SwiftUI

struct SessionComplete: View {
    @EnvironmentObject var yogi: Yogi
    @EnvironmentObject var appTimer: AppTimer
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Meditation Complete")
                .font(.headline)
            Button("Finish") {
                yogi.saveSession(date: Date(), duration: appTimer.timePassed)
                appTimer.reset()
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 32)
            .background(Color(#colorLiteral(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)))
            .cornerRadius(8)
        }
        .padding(.bottom, 16)
        .padding(.horizontal, 32)
        .onAppear(perform: {
            appTimer.pause()
        })
    }
}

struct SessionComplete_Previews: PreviewProvider {
    static var previews: some View {
        let appTimer = AppTimer()
        let yogi = Yogi()
        return SessionComplete()
            .environmentObject(appTimer)
            .environmentObject(yogi)
    }
}

