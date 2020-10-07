//
//  PracticeApp.swift
//  Practice
//
//  Created by Patrick McKowen on 9/12/20.
//

import SwiftUI

@main
struct PracticeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var scenePhase
    
    var appTimer = AppTimer()
    var yogi = Yogi()
    var photoManager = PhotoManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appTimer)
                .environmentObject(yogi)
                .environmentObject(photoManager)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                photoManager.loading = true
                photoManager.showUI = false
                appTimer.reset()
                yogi.lastSeenDate = Date()
                let defaults = UserDefaults.standard
                defaults.set(Date().timeIntervalSince1970, forKey: "LastSeenDate")
                
            }
            if phase == .active {
                if !yogi.lastSeenDate.isToday {
                    photoManager.loadNewPhoto()
                } else {
                    photoManager.loading = false
                    photoManager.showUI = true
                }

            }
        }
    }
}

