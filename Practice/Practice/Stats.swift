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
    
    @AppStorage("ShowAppleHealthPromo") var showAppleHealthPromo = true
    
    let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    var formattedDuration: String {
        let seconds = yogi.totalDuration
        let minutes = seconds / 60
        let hours = seconds / 3600
        let remainderMinutes = (seconds % 3600) / 60
        let minuteFractionOfHour = Double(remainderMinutes) / 60
        let total = Double(hours) + minuteFractionOfHour
        
        if yogi.totalDuration < 3600 {
            return String(minutes)
        } else {
            return String(format: "%.1f", total)
        }
    }
    
    var hoursOrMinutes: String {
        switch yogi.totalDuration {
        case 0..<3600: return "Minutes"
        default: return "Hours"
        }
    }
    
    var hasFirstSession: Bool {
        if yogi.sessions.count == 0 { return false }
        else { return true }
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Image(systemName: "chevron.left")
                    .onTapGesture(perform: {
                        self.presentationMode.wrappedValue.dismiss()
                    })
                Spacer()
                Image(systemName: "trash")
                    .onTapGesture(perform: {
                        yogi.resetData()
                    })
                NavigationLink(
                    destination: Settings(),
                    label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(.black)
                    })
                
            }
            .font(.title3)
            .padding(.top, 12)
            .padding(.horizontal, 24)
            ScrollView(.vertical) {
                // Stats
                VStack {
                    Text("Stats")
                        .font(.system(size: 20, weight: .semibold, design: .serif))
                        .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                        .padding(.bottom, 1)
                    Text(hasFirstSession ? "Since \(yogi.firstSessionDate ?? Date(), formatter: itemFormatter)" : "Log your first meditation session today.")
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.bottom, 16)
                    
                    HStack {
                        // Left Column
                        VStack(spacing: 40) {
                            VStack(spacing: 0) {
                                Text("\(yogi.totalSessions)")
                                    .font(.system(size: 32, weight: .semibold, design: .serif))
                                    .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                                Text("Total Sessions")
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
                                Text("\(formattedDuration)")
                                    .font(.system(size: 32, weight: .semibold, design: .serif))
                                    .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                                Text("Total \(hoursOrMinutes)")
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
                    }
                } // End Stats
                .padding(.top, 16)
                .padding(.bottom, 32)
                .padding(.horizontal, 48)
                
                Rectangle()
                    .fill(Color.black.opacity(0.05))
                    .frame(maxHeight: 8)
                
                // Badges
                VStack() {
                    Text("Streak Badges")
                        .font(.system(size: 20, weight: .semibold, design: .serif))
                        .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                        .padding(.bottom, 1)
                    Text("Earn badges by practicing for consecutive days. Next badge in \(yogi.daysToNextMilestone) sessions.")
                        .fixedSize(horizontal: false, vertical: true)
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
                .padding(.vertical, 32)
                
                if showAppleHealthPromo {
                    AppleHealthPromo()
                        .opacity(showAppleHealthPromo ? 1.0 : 0.0)
                        .animation(.easeOut)
                }
                
                
            } // End Scrollview
            
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
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

