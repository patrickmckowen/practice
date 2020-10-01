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
    
    let url = URL(string: "https://images.unsplash.com/photo-1485841938031-1bf81239b815")!
    
    @State private var showStreak = true
    @State private var showTimerControls = true
    @State private var showTimePicker = false
    @State private var isSessionComplete = false
    
    @Namespace private var playAnimation
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Blur(style: .systemUltraThinMaterialLight)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(appTimer.state == .off ? 0.0 : 1.0)
                
                if showStreak {
                    Streak()
                        .transition(AnyTransition.opacity.combined(with: .move(edge: .top)))
                }
                
                if appTimer.state != .completed && showTimerControls {
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
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .background(
                AsyncImage(url: url, placeholder: {
                    ZStack {
                        Color.black
                            .frame(width: UIScreen.main.bounds.width)
                        Text("Breath")
                            .font(.system(size: 32, weight: .semibold, design: .serif))
                            .foregroundColor(Color.white.opacity(0.4))
                    }
                })
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            )
            
        } // End NavigationView
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

