//
//  PracticeApp.swift
//  Practice
//
//  Created by Patrick McKowen on 9/12/20.
//

import SwiftUI

@main
struct PracticeApp: App {
    var appTimer = AppTimer()
    var yogi = Yogi()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appTimer)
                .environmentObject(yogi)
        }
    }
}

