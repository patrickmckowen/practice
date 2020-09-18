//
//  Stats.swift
//  Practice
//
//  Created by Patrick McKowen on 9/17/20.
//

import SwiftUI

struct Stats: View {
    @EnvironmentObject var yogi: Yogi
    @EnvironmentObject var appTimer: AppTimer
    
    var body: some View {
        ZStack {
            VStack {
                Text("Current Streak: \(yogi.currentStreak)")
                Text("Longest Streak: \(yogi.longestStreak)")
                Text("Total Sessions: \(yogi.totalSessions)")
                Text("Total Time: \(appTimer.formatTime(yogi.totalDuration))")
                ScrollView(.vertical) {
                    SessionList()
                }
            }
            VStack {
                Spacer()
                Button("Reset Data") {
                    yogi.resetData()
                }
                .padding(16)
                .background(Color.white)
                .cornerRadius(32)
                .foregroundColor(.red)
                .padding(.bottom, 16)
            }
        }
    }
}

struct Stats_Previews: PreviewProvider {
    static var previews: some View {
        let appTimer = AppTimer()
        let yogi = Yogi()
        return Stats()
            .environmentObject(appTimer)
            .environmentObject(yogi)
    }
}

