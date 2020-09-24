//
//  ContentView.swift
//  Practice
//
//  Created by Patrick McKowen on 9/12/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var yogi: Yogi
    @EnvironmentObject var appTimer: AppTimer
    
    @State private var timePickerIndex = 0
    
    @Namespace private var playAnimation
    @State var playTapped = false
    
    @State private var showStreak = true
    @State private var showCountdown = false
    @State private var showTimePicker = false
    @State private var showTimerControls = true
    @State private var isSessionComplete = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Blur(style: .systemUltraThinMaterialLight)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(appTimer.state == .off ? 0.0 : 1.0)
                
                if showStreak {
                    Streak()
                        .padding(.horizontal, 16)
                }
                
                if appTimer.state != .completed {
                    TimerControls(showTimePicker: $showTimePicker)
                }
                
                if appTimer.state == .completed {
                    SessionComplete()
                        .onAppear(perform: {
                            guard appTimer.timeRemaining == 0 else { return }
                            saveSession()
                        })
                        .transition(.scale)
                }
            }
            .navigationBarHidden(true)
            .background(Image("default").edgesIgnoringSafeArea(.all))
        }
    }
    
    func saveSession() {
        withAnimation(.spring()) {
            yogi.saveSession(date: Date(), duration: appTimer.timePassed)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let appTimer = AppTimer()
        let yogi = Yogi()
        return ContentView()
            .environmentObject(appTimer)
            .environmentObject(yogi)
    }
}

