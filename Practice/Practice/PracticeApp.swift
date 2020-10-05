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
            }
            if phase == .active {
                yogi.updateStreak()
           //     yogi.updateImage()
            }
        }
    }
}

