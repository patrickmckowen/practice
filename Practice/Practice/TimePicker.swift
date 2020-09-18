//
//  TimePicker.swift
//  Practice
//
//  Created by Patrick McKowen on 9/16/20.
//

import SwiftUI

struct TimePicker: View {
    @EnvironmentObject var appTimer: AppTimer
    @Binding var timePickerIndex: Int
    
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
            .padding(.horizontal, 16)
            
            Button("Set Timer") {
                appTimer.setTimerLength( timePickerIndex)
            }
            .buttonStyle(ButtonPrimary())
            .padding(.bottom, 32)
        }
    }
}

struct TimePicker_Previews: PreviewProvider {
    static var previews: some View {
        let appTimer = AppTimer()
        TimePicker(timePickerIndex: .constant(0))
            .environmentObject(appTimer)
    }
}

