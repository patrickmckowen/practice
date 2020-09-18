//
//  Streak.swift
//  Practice
//
//  Created by Patrick McKowen on 9/17/20.
//

import SwiftUI

struct Streak: View {
    @EnvironmentObject var yogi: Yogi
    @EnvironmentObject var appTimer: AppTimer
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Current Streak: \(yogi.currentStreak)")
            Text("Longest Streak: \(yogi.longestStreak)")
            NavigationLink(destination: Stats()) {
                Text("See All Stats")
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 32)
    }
}

struct Streak_Previews: PreviewProvider {
    static var previews: some View {
        let appTimer = AppTimer()
        let yogi = Yogi()
        return Streak()
            .environmentObject(appTimer)
            .environmentObject(yogi)
    }
}

