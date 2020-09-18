//
//  TimerControlsView.swift
//  Practice
//
//  Created by Patrick McKowen on 9/17/20.
//

import SwiftUI

struct TimerControls: View {
    @EnvironmentObject var yogi: Yogi
    @EnvironmentObject var appTimer: AppTimer
    
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 20) {
                // Pause
                Button(action: { appTimer.pause() }) {
                    Image(systemName: "pause.fill")
                        .font(.title2)
                }
                .buttonStyle(IconButton())
                
                // Play
                Button(action: { appTimer.start() }) {
                    Image(systemName: "play.fill")
                        .font(.title2)
                }
                .buttonStyle(IconButton())
                
                // Reset
                Button(action: { appTimer.reset() }) {
                    Image(systemName: "stop.fill")
                    
                }
                .buttonStyle(IconButton())
            }
            
        }
    }
}

struct TimerControls_Previews: PreviewProvider {
    static var previews: some View {
        let appTimer = AppTimer()
        let yogi = Yogi()
        return TimerControls()
            .environmentObject(appTimer)
            .environmentObject(yogi)
    }
}

