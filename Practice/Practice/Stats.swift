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
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var appleHeathIsOn = UserDefaults.standard.bool(forKey: "AppleHealth")
    @State var remindersIsOn = UserDefaults.standard.bool(forKey: "Reminders")
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                // Stats
                VStack {
                    Text("Stats")
                        .font(.system(size: 18, weight: .semibold, design: .serif))
                        .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                        .padding(.bottom, 16)
                    
                    HStack {
                        // Left Column
                        VStack(spacing: 40) {
                            VStack(spacing: 0) {
                                Text("\(yogi.totalSessions)")
                                    .font(.system(size: 32, weight: .semibold, design: .serif))
                                    .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                                Text("Total sessions")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            VStack(spacing: 0) {
                                Text("\(yogi.currentStreak)")
                                    .font(.system(size: 32, weight: .semibold, design: .serif))
                                    .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                                Text("Current Streak")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Spacer()
                        
                        // Right Column
                        VStack(spacing: 40) {
                            VStack(spacing: 0) {
                                Text("\(appTimer.formatTime(yogi.totalDuration))")
                                    .font(.system(size: 32, weight: .semibold, design: .serif))
                                    .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                                Text("Total minutes")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            VStack(spacing: 0) {
                                Text("\(yogi.longestStreak)")
                                    .font(.system(size: 32, weight: .semibold, design: .serif))
                                    .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                                Text("Longest Streak")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                    } // End Stats
                }
                .padding(.top, 48)
                .padding(.bottom, 24)
                .padding(.horizontal, 48)
                
                Rectangle()
                    .fill(Color.black.opacity(0.05))
                    .frame(maxHeight: 8)
                
                // Badges
                VStack() {
                    Text("Streak Badges")
                        .font(.system(size: 18, weight: .semibold, design: .serif))
                        .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                        .padding(.bottom, 1)
                    Text("Earn badges by practicing for consecutive days. Next badge in \(yogi.daysToNextMilestone) sessions.")
                        .multilineTextAlignment(.center)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 16)
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 8) {
                            MilestoneBadge(isSmall: true, goal: 7, prevGoal: 0, currentStreak: yogi.currentStreak, longestStreak: yogi.longestStreak)
                            MilestoneBadge(isSmall: true, goal: 14, prevGoal: 7, currentStreak: yogi.currentStreak, longestStreak: yogi.longestStreak)
                            MilestoneBadge(isSmall: true, goal: 30, prevGoal: 14, currentStreak: yogi.currentStreak, longestStreak: yogi.longestStreak)
                            MilestoneBadge(isSmall: true, goal: 60, prevGoal: 30, currentStreak: yogi.currentStreak, longestStreak: yogi.longestStreak)
                            MilestoneBadge(isSmall: true, goal: 90, prevGoal: 60, currentStreak: yogi.currentStreak, longestStreak: yogi.longestStreak)
                            MilestoneBadge(isSmall: true, goal: 180, prevGoal: 90, currentStreak: yogi.currentStreak, longestStreak: yogi.longestStreak)
                            MilestoneBadge(isSmall: true, goal: 270, prevGoal: 180, currentStreak: yogi.currentStreak, longestStreak: yogi.longestStreak)
                            MilestoneBadge(isSmall: true, goal: 365, prevGoal: 270, currentStreak: yogi.currentStreak, longestStreak: yogi.longestStreak)
                        }
                        .frame(height: 108)
                        .padding(.leading, 16)
                    }
                } // End Badges
                .padding(.top, 24)
                .padding(.bottom, 24)
                
                Rectangle()
                    .fill(Color.black.opacity(0.05))
                    .frame(maxHeight: 8)
                
                // Settings
                // TODO: Save in UserDefaults
                // TODO: // Add DatePicker to select prefered time
                VStack {
                    Text("Settings")
                        .font(.system(size: 18, weight: .semibold, design: .serif))
                        .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                        .padding(.bottom, 16)
                    
                    // Apple Health
                    Toggle(isOn: $appleHeathIsOn) {
                        // Text
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Apple Health")
                                .font(.body)
                                .padding(.bottom, 4)
                                .padding(.top, 12)
                            
                            Text("Save your mindfulness minutes on Apple Health App.")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .padding(.bottom, 12)
                        }
                        .foregroundColor(.black)
                    }
                    .padding(.horizontal, 24)
                    // end Apple Health Toggle
                    
                    // Divider
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 1)
                        .foregroundColor(Color.black.opacity(0.1))
                        .padding(.leading, 32)
                    
                    // Reminders
                    Toggle(isOn: $remindersIsOn) {
                        // Text
                        VStack(alignment: .leading) {
                            Text("Reminders")
                                .font(.body)
                                .padding(.vertical, 12)
                        }
                        .foregroundColor(.black)
                    }
                    .padding(.horizontal, 24)
                    // end Apple Health Toggle
                    
                    
                } // end Settings VStack container
                .padding(.top, 24)
                
                
            } // End Scrollview
            
            // TODO: Remove test controls
            Image(systemName: "trash")
                .position(x: UIScreen.main.bounds.width - 56, y: 0)
                .font(.system(size: 24))
                .foregroundColor(.black)
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .onTapGesture {
                    yogi.resetData()
                }
            
            // Back Button
            Image(systemName: "chevron.left")
                .position(x: 8, y: 0)
                .font(.system(size: 24))
                .foregroundColor(.black)
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
        }
        .navigationBarHidden(true)
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

