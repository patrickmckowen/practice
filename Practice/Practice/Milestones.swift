//
//  Milestones.swift
//  Practice
//
//  Created by Patrick McKowen on 9/23/20.
//

import SwiftUI

struct MilestoneBadge: View {
    @EnvironmentObject var yogi: Yogi
    
    enum Size {
        case small
        case large
    }
    
    var size: Size
    
    var goal: Int
    var prevGoal: Int
    var currentStreak: Int
    var longestStreak: Int
    var progress: Double {
        return Double(currentStreak) / Double(goal)
    }
    
    var isLocked: Bool {
        if longestStreak <= prevGoal {
            return true
        } else {
            return false
        }
    }
    
    var hasAchieved: Bool {
        if longestStreak >= goal {
            return true
        } else {
            return false
        }
    }
    
    let gradient = LinearGradient(gradient:Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.6078431373, blue: 0.4509803922, alpha: 1)), Color(#colorLiteral(red: 0.4901960784, green: 0.4196078431, blue: 0.8980392157, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    var body: some View {
        ZStack {
            if !hasAchieved && !isLocked {
                // Stroke Background
                Circle()
                    .stroke(lineWidth: 5.0)
                    .foregroundColor(Color.black.opacity(0.2))
                    .frame(width: 140)
                
                // Stroke Fill
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                    .stroke(gradient, style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                    .frame(width: 140)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear)
            }
            //  Circle Fill
            Circle()
                .fill(gradient)
                .frame(width: hasAchieved || isLocked ? 144 : 124, height: hasAchieved || isLocked ? 144 : 124)
                .opacity(isLocked ? 0.3 : 1.0)
            
            if isLocked {
                Image(systemName: "lock.fill")
                    .font(.title)
                    .foregroundColor(Color(#colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)))
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2.0)
            }
            
            if !isLocked {
                VStack(spacing: 0) {
                    Image("lotus")
                    Text("\(goal)")
                        .font(.system(size: 56, weight: .semibold, design: .serif))
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 2.0)
                        .padding(.top, -8)
                }
            }
        }
    }
}

struct Milestone_Previews: PreviewProvider {
    static var previews: some View {
        let yogi = Yogi()
        return MilestoneBadge(size: .large, goal: 90, prevGoal: 60, currentStreak: yogi.currentStreak, longestStreak: yogi.longestStreak)
            .environmentObject(yogi)
    }
}
