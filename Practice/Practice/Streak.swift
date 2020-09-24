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
    
    var progressBarAmount: Double {
        let s = Double(yogi.currentStreak)
        let m = Double(yogi.longestStreak)
        let p = s / m
        return p
    }
    
    var showMilestone: Bool {
        if yogi.currentStreak >= yogi.longestStreak ||
            yogi.longestStreak == yogi.nextMilestone {
            return true
        } else {
            return false
        }
    }
    
    var body: some View {
        ZStack {
            VStack {
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0.0)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 220)
                Spacer()
            }
            
            VStack(spacing: 0) {
                // Streak Numbers
                HStack(spacing: 0) {
                    // Current
                    VStack(alignment: .leading, spacing: 0) {
                        Text("\(yogi.currentStreak)")
                            .font(.system(size: 40, weight: .semibold, design: .serif))
                            .padding(.bottom, -2)
                        Text("Day streak")
                            .font(.system(size: 14))
                    }
                    .foregroundColor(.white)
                    Spacer()
                    // Next
                    VStack(alignment: .trailing, spacing: 0) {
                        Text("\(showMilestone ? yogi.nextMilestone : yogi.longestStreak)")
                            .font(.system(size: 40, weight: .semibold, design: .serif))
                            .padding(.bottom, -2)
                        Text(showMilestone ? "Next Milestone" : "Longest streak")
                            .font(.system(size: 14))
                    }
                    .foregroundColor(.white)
                    
                } // end Streak Numbers
                
                // Progress Bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: geo.size.width , height: 5)
                            .foregroundColor(Color.white.opacity(0.2))
                        
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: geo.size.width * CGFloat(progressBarAmount), height: 5)
                            .foregroundColor(Color.white)
                    }
                }
                .padding(.top, 8)
                
                Spacer()
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 32)
        }
        .onAppear(perform: {
            yogi.updateStreak()
        })
        .offset(y: appTimer.state == .off ? 0 : -10)
        .opacity(appTimer.state == .off ? 1.0 : 0.0)
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

