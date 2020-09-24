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
    
    var nextMilestone = 30
    var prevMilestone = 14
    
    var daysToNextMilestone: Int {
        return nextMilestone - yogi.currentStreak
    }
    
    var body: some View {
        // Main Container
        VStack(spacing: 16) {
            VStack(spacing: 0) {
                Text("Meditation Complete")
                    .font(.system(size: 16, weight: .semibold, design: .serif))
                    .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                    .padding(.top, 24)
                    .padding(.bottom, 4)
                
                Text("Session time: \(appTimer.formatTime(appTimer.timeRemaining))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 16)
                
                Rectangle()
                    .fill(Color.black.opacity(0.1))
                    .frame(maxWidth: .infinity, maxHeight: 0.5)
                    .padding(.bottom, 24)
                
                MilestoneBadge(isSmall: false, goal: nextMilestone, prevGoal: prevMilestone, currentStreak: yogi.currentStreak, longestStreak: yogi.longestStreak)
                    .frame(maxHeight: 144)
                    .padding(.bottom, 8)
                
                Text("Next milestone in \(daysToNextMilestone) days")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 24)
                
                Rectangle()
                    .fill(Color.black.opacity(0.15))
                    .frame(maxWidth: .infinity, maxHeight: 0.5)
                    .padding(.bottom, 24)
                
                HStack {
                    VStack(spacing: 0) {
                        Text("\(yogi.currentStreak)")
                            .font(.system(size: 32, weight: .semibold, design: .serif))
                            .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                        Text("Current Streak")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    
                    VStack(spacing: 0) {
                        Text("\(yogi.longestStreak)")
                            .font(.system(size: 32, weight: .semibold, design: .serif))
                            .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                        Text("Longest Streak")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 24)
                
                
            } // End Main Container
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(8)
            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1)), radius:2, x:0, y:0)
            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15)), radius:8, x:0, y:2)
            .padding(.horizontal, 16)
            
            Button("Finish") {
                withAnimation(.default) {
                    appTimer.reset()
                }
            }
            .buttonStyle(ButtonLight())
        }
        .opacity(appTimer.state == .completed ? 1.0 : 0.0)
        .scaleEffect(appTimer.state == .completed ? 1 : 0, anchor: .bottom)

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

