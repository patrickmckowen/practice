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
    
    @State private var showStreak = true
    @State private var showCountdown = true
    @State private var showTimePicker = true
    @State private var showTimerControls = true
    @State private var isSessionComplete = false
    
    var body: some View {
        NavigationView {
            VStack() {
                // Stats
                if showStreak { Streak() }
                
                // Countdown
                if showCountdown {
                    Countdown()
                    Button("Save Session") {
                        yogi.saveSession(date: Date(), duration: appTimer.timePassed)
                        appTimer.reset()
                    }
                }
                
                // Session Complete
                if isSessionComplete { SessionComplete() }
                
                // Timer Controls
                if showTimerControls { TimerControls() }
                
            }
        }
    }
}

struct IconButton: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.title2)
            .foregroundColor(.blue)
            .padding(20)
            .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .cornerRadius(100)
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
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

