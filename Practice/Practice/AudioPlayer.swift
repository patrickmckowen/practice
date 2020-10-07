//
//  AudioPlayer.swift
//  Practice
//
//  Created by Patrick McKowen on 9/25/20.
//

import SwiftUI
import AVFoundation

var audioPlayer: AVAudioPlayer?
let audioSession = AVAudioSession.sharedInstance()

func playSound(sound: String, type: String) {
    
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        let url = URL(fileURLWithPath: path)
        do {
            try audioSession.setCategory(.playAndRecord, options: .defaultToSpeaker)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Couldn't find sound file")
        }
    }
}

func stopSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        let url = URL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.stop()
        } catch {
            print("Couldn't find sound file")
        }
    }
}
