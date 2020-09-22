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
                // Blur background image when timer is running
                Blur(style: .systemUltraThinMaterialLight)
                    .edgesIgnoringSafeArea(.all)
                    .opacity(appTimer.state == .off ? 0.0 : 1.0)
                
                VStack() {
                    if showStreak { Streak() }
                    
                    if isSessionComplete { SessionComplete() }
                    
                }
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height)
                
                // Timer Controls
                TimerControls(showTimePicker: $showTimePicker)
            }
            .navigationBarHidden(true)
            .background(Image("default").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
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

