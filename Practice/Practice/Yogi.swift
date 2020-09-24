//
//  Yogi.swift
//  Practice
//
//  Created by Patrick McKowen on 9/12/20.
//

import Foundation

struct Session: Codable, Identifiable {
    var id = UUID()
    let date: Date
    let duration: TimeInterval
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
    @Published var totalDuration: TimeInterval = 0
    @Published var lastSessionDate: Date?
    @Published var currentStreak: Int = UserDefaults.standard
        .integer(forKey: "CurrentStreak")
    @Published var longestStreak: Int = 26
        //UserDefaults.standard.integer(forKey: "LongestStreak")
    
    @Published var hitMilestone7: Bool = false
    @Published var milestone7Active: Bool = false
    @Published var hitMilestone14: Bool = false
    @Published var hitMilestone30: Bool = false
    
    func saveSession(date: Date, duration: TimeInterval) {
        let newSession = Session(date: date, duration: duration)
        sessions.append(newSession)
        
        totalSessions += 1
        totalDuration += duration
        
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
    
    func updateMilestones() {
        let streak = longestStreak
        if streak >= 7 { hitMilestone7 = true }
        if streak >= 14 { hitMilestone14 = true }
        if streak >= 30 { hitMilestone30 = true }
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
        UserDefaults.standard.synchronize()
    }
}

