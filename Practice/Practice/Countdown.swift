//
//  Countdown.swift
//  Practice
//
//  Created by Patrick McKowen on 9/17/20.
//

import SwiftUI

struct Countdown: View {
    @EnvironmentObject var yogi: Yogi
    @EnvironmentObject var appTimer: AppTimer
    
    var body: some View {
        Text("\(appTimer.formatTime(appTimer.timeRemaining))")
            .font(Font.custom("NewYorkLarge-Regular", size: 32).monospacedDigit())
    }
}

struct Countdown_Previews: PreviewProvider {
    static var previews: some View {
        let appTimer = AppTimer()
        let yogi = Yogi()
        return Countdown()
            .environmentObject(appTimer)
            .environmentObject(yogi)
    }
}

