//
//  Playground.swift
//  Practice
//
//  Created by Patrick McKowen on 9/22/20.
//

import SwiftUI

struct Playground: View {
    @EnvironmentObject var yogi: Yogi
    @EnvironmentObject var appTimer: AppTimer
    
    var progress: Double {
        let options = appTimer.lengthOptions
        let index = appTimer.timePickerIndex
        let minutes = options[index]
        let seconds = Double(minutes * 60)
        let countTo = seconds
        
        let timePassed = appTimer.timePassed
        
        return Double(timePassed / countTo)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                // Background Stroke
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                    .frame(width: 144, height: 144)
                    .foregroundColor(Color.white.opacity(0.5))
                
                // Filled Stroke
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                    .rotationEffect(Angle(degrees: 270.0))
                    .frame(width: 144, height: 144)
                    .foregroundColor(Color.white.opacity(1.0))
                
                Image(systemName:
                        appTimer.state != .running
                        ? "play.fill" : "pause.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 48, maxHeight: 48)
                    .foregroundColor(.white)
                    .shadow(color: Color/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.3), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 4.0)
                
            }
            
        }
        .background(Image("default")).edgesIgnoringSafeArea(.all)
    }
}



struct Playground_Previews: PreviewProvider {
    static var previews: some View {
        let appTimer = AppTimer()
        let yogi = Yogi()
        return Playground()
            .environmentObject(appTimer)
            .environmentObject(yogi)
    }
}
