//
//  Yogi.swift
//  Practice
//
//  Created by Patrick McKowen on 9/12/20.
//

import Foundation
import HealthKit

struct Session: Codable, Identifiable {
    var id = UUID()
    let date: Date
    let duration: Int
}

class Yogi: ObservableObject {
    @Published var sessions = [Session]() {
        didSet {
            let enc = JSONEncoder()
            if let encoded = try? enc.encode(sessions) {
                UserDefaults.standard.set(encoded, forKey: "Sessions")
            } else {
                print("ERROR in encoding")
            }
        }
    }
    
    @Published var totalSessions: Int = 0
    @Published var totalDuration: Int = 0
    @Published var lastSessionDate: Date?
    @Published var currentStreak: Int = UserDefaults.standard.integer(forKey: "CurrentStreak")
    @Published var longestStreak: Int = UserDefaults.standard.integer(forKey: "LongestStreak")
    
    @Published var hitMilestone: Bool = false
    @Published var nextMilestone: Int = 7
    @Published var currentMilestone: Int = 7
    
    var daysToNextMilestone: Int {
        return nextMilestone - currentStreak
    }
    
    /*
     var milestoneReached: Bool {
     if currentStreak == nextMilestone {
     return true
     } else {
     return false
     }
     }
     */
    
    // HealthKit
    @Published var showAppleHealthButton = true
    let healthStore = HKHealthStore()
    let mindfulType = HKObjectType.categoryType(forIdentifier: .mindfulSession)
    let mindfulSession = HKCategoryTypeIdentifier.mindfulSession
    
    func activateHealthKit() {
        let typestoShare = Set([
            HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.mindfulSession)!
        ])
        
        self.healthStore.requestAuthorization(toShare: typestoShare, read: nil) { (success, error) -> Void in
            if success {
                self.showAppleHealthButton = false
                UserDefaults.standard.set(self.showAppleHealthButton, forKey: "ShowAppleHealthButton")
            }
        }
    }
    
    func saveSession(date: Date, duration: Int) {
        let newSession = Session(date: date, duration: duration)
        sessions.append(newSession)
        
        // Adding to Apple Health
        // Check if permissions granted
        let authorizationStatus = healthStore.authorizationStatus(for: HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.mindfulSession)!)
        if authorizationStatus == .sharingAuthorized &&
            UserDefaults.standard.bool(forKey: "AppleHealthIsOn") == true {
            let startTime = date
            let endTime = date.addingTimeInterval(Double(duration))
            let mindfullSample = HKCategorySample(type:mindfulType!, value: 0, start: startTime, end: endTime)
            // Save it to the health store
            healthStore.save(mindfullSample, withCompletion: { (success, error) -> Void in
                if error != nil {return}
                
                print("New data was saved in HealthKit: \(success)")
            })
        }
        
        totalSessions += 1
        totalDuration += duration
        
        if currentStreak == 0 { currentStreak = 1}
        if longestStreak == 0 { longestStreak = 1 }
        
        if currentStreak == 0 { currentStreak = 1}
        if longestStreak == 0 { longestStreak = 1 }
        
        if let lastSession = lastSessionDate {
            if lastSession.isYesterday {
                currentStreak += 1
            } else if lastSession.isToday {
                return
            } else {
                currentStreak = 1
            }
        }
        
        if currentStreak >= longestStreak {
            longestStreak = currentStreak
        }
        
        lastSessionDate = date
        
        let defaults = UserDefaults.standard
        defaults.set(currentStreak, forKey: "CurrentStreak")
        defaults.set(longestStreak, forKey: "LongestStreak")
    }
    
    func checkStreak() {
        if let lastSession = lastSessionDate {
            if lastSession.isToday || lastSession.isYesterday {
                currentStreak = UserDefaults.standard
                    .integer(forKey: "CurrentStreak")
            } else {
                currentStreak = 0
                let defaults = UserDefaults.standard
                defaults.set(currentStreak, forKey: "CurrentStreak")
            }
        }
    }
    
    func updateMilestones() {
        switch longestStreak {
        case 0..<7:
            nextMilestone = 7
            hitMilestone = false
        case 7:
            currentMilestone = 7
            nextMilestone = 14
            hitMilestone = true
        case 8..<14:
            nextMilestone = 14
            hitMilestone = false
        case 14:
            currentMilestone = 14
            nextMilestone = 30
            hitMilestone = true
        case 15..<30:
            nextMilestone = 30
            hitMilestone = false
        case 30:
            currentMilestone = 30
            nextMilestone = 60
            hitMilestone = true
        case 31..<60:
            nextMilestone = 60
            hitMilestone = false
        case 60:
            currentMilestone = 60
            nextMilestone = 90
            hitMilestone = true
        case 61..<90:
            nextMilestone = 90
            hitMilestone = false
        case 90:
            currentMilestone = 90
            nextMilestone = 180
            hitMilestone = true
        case 91..<180:
            nextMilestone = 180
            hitMilestone = false
        case 180:
            currentMilestone = 180
            nextMilestone = 270
            hitMilestone = true
        case 181..<270:
            nextMilestone = 270
            hitMilestone = false
        case 270:
            currentMilestone = 270
            nextMilestone = 365
            hitMilestone = true
        case 271..<365:
            nextMilestone = 365
            hitMilestone = false
        case 365:
            currentMilestone = 365
            nextMilestone = 1000
            hitMilestone = true
        default:
            nextMilestone = 1000
            hitMilestone = false
        }
    }
    
    init(){
        if let savedSessions = UserDefaults.standard.object(forKey: "Sessions") as? Data {
            let decoder = JSONDecoder()
            if let loadedSessions = try? decoder.decode([Session].self, from: savedSessions) {
                sessions = loadedSessions
                totalSessions = loadedSessions.count
                totalDuration = sessions.reduce(0) { $0 + $1.duration }
                lastSessionDate = loadedSessions.last?.date
                if let lastSession = lastSessionDate {
                    if lastSession.isToday || lastSession.isYesterday {
                        currentStreak = UserDefaults.standard
                            .integer(forKey: "CurrentStreak")
                    } else {
                        currentStreak = 0
                        let defaults = UserDefaults.standard
                        defaults.set(currentStreak, forKey: "CurrentStreak")
                    }
                }
                
            } else {
                print("Error decoding Sessions")}
        } else {
            print("Saved Sessions is empty")
        }
    }
    
    func resetData() {
        UserDefaults.standard.removeObject(forKey: "Sessions")
        UserDefaults.standard.removeObject(forKey: "CurrentStreak")
        UserDefaults.standard.removeObject(forKey: "LongestStreak")
        UserDefaults.standard.removeObject(forKey: "TimePickerIndex")
        UserDefaults.standard.removeObject(forKey: "TimerStart")
        UserDefaults.standard.removeObject(forKey: "NextMilestone")
        UserDefaults.standard.removeObject(forKey: "AppleHealthIsOn")
        UserDefaults.standard.synchronize()
    }
}

