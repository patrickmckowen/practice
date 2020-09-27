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
    
    let lengthOptions = [1, 5, 10, 15, 20, 30, 45, 60]
    @Published var timePickerIndex = UserDefaults.standard.integer(forKey: "TimePickerIndex")    
    @Published var timeRemaining: Int = UserDefaults.standard.integer(forKey: "TimerStart")
    @Published var timePassed: Int = 0
    
    func setTimerLength(_ index: Int) {
        let minutes = lengthOptions[index]
        let seconds = minutes * 60
        timeRemaining = seconds
        
        let defaults = UserDefaults.standard
        defaults.set(timeRemaining, forKey: "TimerStart")
    }
    
    func formatTime(_ time: Int) -> String {
        let minutes = time / 60 % 60
        let seconds = time % 60
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
        }
        
        if timeRemaining == 0 {
            timer.invalidate()
            state = .completed
        }
    }
    
    func pause() {
        guard state == .running else { return }
        stopSound(sound: "sound-forged-bowl", type: "mp3")
        timer.invalidate()
        state = .paused
    }
    
    func reset() {
        timer.invalidate()
        timeRemaining = UserDefaults.standard.integer(forKey: "TimerStart")
        timePassed = 0
        state = .off
    }
    
    init() {
        // Set the timer to 5min for new users
        let defaults = UserDefaults.standard
        if defaults.integer(forKey: "TimerStart") == 0 {
            timeRemaining = 300
            defaults.set(timeRemaining, forKey: "TimerStart")
        }
    }
}

