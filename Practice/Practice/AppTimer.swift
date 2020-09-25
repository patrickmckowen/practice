//
//  AppTimer.swift
//  Practice
//
//  Created by Patrick McKowen on 9/15/20.
//

import Foundation
import AVFoundation

class AppTimer: ObservableObject {
    
    enum TimerMode {
        case off
        case paused
        case running
        case completed
    }
    
    var timer = Timer()
    @Published var state: TimerMode = .off
    
    let lengthOptions = [5, 10, 15, 20, 30, 45, 60]
    @Published var timePickerIndex = UserDefaults.standard.integer(forKey: "TimePickerIndex")    
    @Published var timeRemaining: TimeInterval = UserDefaults.standard.double(forKey: "TimerStart")
    @Published var timePassed: TimeInterval = 0
    
    func setTimerLength(_ index: Int) {
        let minutes = lengthOptions[index]
        let seconds = Double(minutes) * 60
        timeRemaining = seconds
        
        let defaults = UserDefaults.standard
        defaults.set(timeRemaining, forKey: "TimerStart")
    }
    
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%01i:%02i", minutes, seconds)
    }
    
    func start() {
        guard state != .running else { return }
        
        if state != .paused {
            playSound(sound: "sound-forged-bowl", type: "mp3")
        }
        
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: (#selector(runTimer)),
            userInfo: nil,
            repeats: true)
        timer.tolerance = 0.2
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        
        state = .running
    }
    
    @objc func runTimer() {
        timePassed += 1
        
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            playSound(sound: "sound-forged-bowl", type: "mp3")
            state = .completed
        }
    }
    
    func pause() {
        guard state == .running else { return }
        
        timer.invalidate()
        state = .paused
    }
    
    func reset() {
        timer.invalidate()
        timeRemaining = UserDefaults.standard.double(forKey: "TimerStart")
        timePassed = 0
        state = .off
    }
    
    init() {
        // Set the timer to 5min for new users
        let defaults = UserDefaults.standard
        if defaults.double(forKey: "TimerStart") == 0 {
            timeRemaining = 300
            defaults.set(timeRemaining, forKey: "TimerStart")
        }
    }
}

