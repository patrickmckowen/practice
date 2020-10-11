//
//  ContentView.swift
//  Practice
//
//  Created by Patrick McKowen on 9/12/20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    @EnvironmentObject var yogi: Yogi
    @EnvironmentObject var appTimer: AppTimer
    @EnvironmentObject var photoManager: PhotoManager
    
    // Timer
    @State private var showStreak = true
    @State private var showTimerControls = true
    @State private var showTimePicker = false
    @State private var isSessionComplete = false
    
    @Namespace private var playAnimation
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Blur(style: photoManager.isDarkImage ? .systemUltraThinMaterialLight : .systemUltraThinMaterialDark)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(appTimer.state == .off ? 0.0 : 1.0)
                    .animation(Animation.linear.delay(0.1))
                
                if showStreak && photoManager.showUI {
                    Streak()
                        .transition(AnyTransition.opacity.combined(with: .move(edge: .top)))
                }
                
                if appTimer.state != .completed && showTimerControls && photoManager.showUI {
                    TimerControls(showTimePicker: $showTimePicker)
                        .transition(AnyTransition.opacity.combined(with: .move(edge: .bottom)))
                }
                
                if appTimer.state == .completed {
                    SessionComplete()
                        .onAppear(perform: {
                            guard appTimer.timeRemaining == 0 else { return }
                            playSound(sound: "sound-forged-bowl", type: "mp3")
                            withAnimation(.spring()) {
                                yogi.saveSession(date: Date(), duration: appTimer.timePassed)
                            }
                        })
                        .transition(.scale)
                }
                
                if photoManager.loading {
                    ZStack {
                        Color.black
                        Text("Take a deep breath")
                            .foregroundColor(Color.white.opacity(0.5))
                            .font(.system(size: 20, weight: .semibold, design: .serif))
                    }
                    .opacity(photoManager.loading ? 1.0 : 0.0)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .background(
                ZStack {
                    Photo()
                        .edgesIgnoringSafeArea(.all)
                }
            )
        } // End NavigationView
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let appTimer = AppTimer()
        let yogi = Yogi()
        let photoManager = PhotoManager()
        return ContentView()
            .environmentObject(appTimer)
            .environmentObject(yogi)
            .environmentObject(photoManager)
    }
}

