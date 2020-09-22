//
//  TimePicker.swift
//  Practice
//
//  Created by Patrick McKowen on 9/16/20.
//

import SwiftUI

struct TimePicker: View {
    @EnvironmentObject var appTimer: AppTimer
    @State private var timePickerIndex = 0
    @Binding var showTimePicker: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Picker(selection: $timePickerIndex, label: Text("Session Length")) {
                ForEach(0 ..< appTimer.lengthOptions.count) {
                    Text("\(appTimer.lengthOptions[$0]) minutes")
                }
            }
            .background(Color.white)
            .cornerRadius(8)
            .frame(width: UIScreen.main.bounds.width - 32)
            
            Button("Done") {
                appTimer.setTimerLength(timePickerIndex)
                appTimer.timePickerIndex = self.timePickerIndex
                
                let defaults = UserDefaults.standard
                defaults.set(self.timePickerIndex, forKey: "TimePickerIndex")
                
                showTimePicker = false
                
            }
            .buttonStyle(ButtonLight())
            .padding(.bottom, 32)
        }
        .transition(.move(edge: .bottom))
    }
}

struct TimePicker_Previews: PreviewProvider {
    static var previews: some View {
        let appTimer = AppTimer()
        TimePicker(showTimePicker: .constant(true))
            .environmentObject(appTimer)
    }
}

