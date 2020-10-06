//
//  PracticeApp.swift
//  Practice
//
//  Created by Patrick McKowen on 9/12/20.
//

import SwiftUI

@main
struct PracticeApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    var appTimer = AppTimer()
    var yogi = Yogi()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appTimer)
                .environmentObject(yogi)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                print("App entered background")
                let defaults = UserDefaults.standard
                defaults.set(Date().timeIntervalSince1970, forKey: "LastSeenDate")
                print("Last seen date set: \(Date().timeIntervalSince1970)")
                print("Yogi lastSeenDate updated to: \(yogi.lastSeenDate)")
                
            }
            if phase == .active {
                print("App became active")
                yogi.updateStreak()
                print("Streak updated")
            }
        }
    }
}

