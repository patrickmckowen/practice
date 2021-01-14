//
//  AppDelegate.swift
//  Practice
//
//  Created by Patrick McKowen on 10/11/20.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UIApplication.shared.isIdleTimerDisabled = true
        return true
    }
}
