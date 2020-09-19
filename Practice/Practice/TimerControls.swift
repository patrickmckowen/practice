//
//  TimerControlsView.swift
//  Practice
//
//  Created by Patrick McKowen on 9/17/20.
//

import SwiftUI

struct TimerControls: View {
    @EnvironmentObject var yogi: Yogi
    @EnvironmentObject var appTimer: AppTimer
    
    @State private var showTimePicker = false
    
    var duration: Int {
        let options = appTimer.lengthOptions
        let index = appTimer.timePickerIndex
        return options[index]
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 20) {
                // Duration
                Button(action: { showTimePicker = true }) {
                    Image(systemName: "timer")
                    Text("\(duration)m")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.black)
                //    .shadow(color: Color.black.opacity(0.1), radius: 2.0, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 1.0)
                .padding(.leading, 48)
                .frame(width: UIScreen.main.bounds.width / 3)
                // end Duration
                
                // Play
                ZStack {
                    Circle()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.white)
                        .shadow(color: Color/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.1), radius: 12, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)
                    Image(systemName:
                            appTimer.state != .running
                            ? "play.fill" : "pause.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 32, maxHeight: 32)
                        .foregroundColor(.black)
                    
                }
                .frame(width: UIScreen.main.bounds.width / 3)
                .onTapGesture(perform: {
                    appTimer.state != .running
                        ? appTimer.start()
                        : appTimer.pause()
                })
                // End Play
                
                // Stats
                NavigationLink(
                    destination: Stats(),
                    label: {
                        Image(systemName: "person.crop.circle")
                        Text("Stats")
                            .fontWeight(.semibold)
                    })
                    .foregroundColor(.black)
                    //     .shadow(color: Color.black.opacity(0.1), radius: 2.0, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 1.0)
                    .padding(.trailing, 48)
                    .frame(width: UIScreen.main.bounds.width / 3)
                // end Stats
            }
            .opacity(showTimePicker ? 0.0 : 1.0)
            // end HStack
        }
        
        // TimePicker
        if showTimePicker { TimePicker(showTimePicker: $showTimePicker) }
    }
}

struct TimerControls_Previews: PreviewProvider {
    static var previews: some View {
        let appTimer = AppTimer()
        let yogi = Yogi()
        return TimerControls()
            .environmentObject(appTimer)
            .environmentObject(yogi)
    }
}

