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
    
    let gradient = LinearGradient(gradient:Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.6078431373, blue: 0.4509803922, alpha: 1)), Color(#colorLiteral(red: 0.4901960784, green: 0.4196078431, blue: 0.8980392157, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    @State var expand = false
    @State var fade = false
    
    var body: some View {
        // Main Container
        VStack(spacing: 16) {
            VStack(spacing: 0) {
                Text("Meditation Complete")
                    .font(.system(size: 16, weight: .semibold, design: .serif))
                    .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                    .padding(.top, 24)
                    .padding(.bottom, 4)
                
                Text("Session time: \(appTimer.formatTime(appTimer.timePassed))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 16)
                
                Rectangle()
                    .fill(Color.black.opacity(0.1))
                    .frame(maxWidth: .infinity, maxHeight: 0.5)
                    .padding(.bottom, 24)
                
                if yogi.hitMilestone {
                        ZStack {
                            Circle()
                                .fill(gradient)
                                .opacity(0.45)
                                .frame(width: 200, height: 200)
                                .scaleEffect(expand ? 1 : 0)
                                .opacity(fade ? 0 : 1)

                            MilestoneBadge(isSmall: false, goal: yogi.currentMilestone, prevGoal: 0, currentStreak: yogi.currentStreak, longestStreak: yogi.longestStreak)
                                .frame(maxHeight: 144)
                            Text("You've earned a new streak badge!")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .offset(y: 92)
                        }
                        .onAppear(perform: {
                            guard yogi.hitMilestone == true else { return }
                            withAnimation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: false)) {
                                expand.toggle()
                                
                            }
                            
                            withAnimation(Animation.linear(duration: 2).delay(2).repeatForever(autoreverses: false)) {
                                fade.toggle()
                            }
                            
                        })
                        .padding(.top, -32)
                        .padding(.bottom, 24)
                    
                }
                if !yogi.hitMilestone {
                    MilestoneBadge(isSmall: false, goal: yogi.nextMilestone, prevGoal: 0, currentStreak: yogi.currentStreak, longestStreak: yogi.longestStreak)
                        .frame(maxHeight: 144)
                        .padding(.bottom, 8)
                    Text("Next streak badge in \(yogi.daysToNextMilestone) sessions")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 24)
                }
                
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

