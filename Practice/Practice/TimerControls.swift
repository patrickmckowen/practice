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
    
    @Binding var showTimePicker: Bool
    
    @Namespace var playAnimation
    @State var playTapped = false
    
    var duration: Int {
        let options = appTimer.lengthOptions
        let index = appTimer.timePickerIndex
        return options[index]
    }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0.0)]), startPoint: .bottom, endPoint: .top)
                    .edgesIgnoringSafeArea(.bottom)
                    .frame(height: 212)
            }
            .opacity(appTimer.state == .off ? 1.0 : 0.0)
            
            VStack {
                Spacer()
                HStack(spacing: 20) {
                    // Duration
                    Button(action: { showTimePicker = true }) {
                        Image(systemName: "timer")
                        Text("\(duration)m")
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 2.0, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 1.0)
                    .padding(.leading, 48)
                    .frame(width: UIScreen.main.bounds.width / 3)
                    // end Duration
                    
                    // Play
                    if appTimer.state == .off {
                        ZStack {
                            Circle()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.white)
                                .shadow(color: Color/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.08), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 4.0)
                            Image(systemName:
                                    appTimer.state != .running
                                    ? "play.fill" : "pause.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 32, maxHeight: 32)
                                .foregroundColor(.black)
                            
                        }
                        .matchedGeometryEffect(id: "PlayButton", in: playAnimation)
                        .frame(width: UIScreen.main.bounds.width / 3)
                        .onTapGesture(perform: {
                            if appTimer.state == .off {
                                withAnimation(.spring()) {
                                    appTimer.start()
                                }
                            } else if appTimer.state == .running {
                                appTimer.pause()
                            }
                        })
                    }
                    // End Play
                    
                    // Stats
                    NavigationLink(
                        destination: Stats(),
                        label: {
                            Image(systemName: "person.crop.circle")
                            Text("Stats")
                                .fontWeight(.semibold)
                        })
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 2.0, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 1.0)
                        .padding(.trailing, 48)
                        .frame(width: UIScreen.main.bounds.width / 3)
                    // end Stats
                }
                .padding(.bottom, 32)
                .opacity(showTimePicker ? 0.0 : 1.0)
                // end HStack
                
                if showTimePicker { TimePicker(showTimePicker: $showTimePicker) }
            }
            .opacity(appTimer.state == .off ? 1.0 : 0.0)
            
            if appTimer.state != .off {
                ZStack {
                    // Play Button
                    ZStack {
                        Circle()
                            .frame(width: 124, height: 124)
                            .foregroundColor(.white)
                            .shadow(color: Color/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.08), radius: 8, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 4.0)
                        Image(systemName:
                                appTimer.state != .running
                                ? "play.fill" : "pause.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 40, maxHeight: 40)
                            .foregroundColor(.black)
                        
                    }
                    .matchedGeometryEffect(id: "PlayButton", in: playAnimation)
                    .onTapGesture(perform: {
                        appTimer.state == .running ? appTimer.pause() : appTimer.start()
                    }) // End Play Button
                    
                    // Countdown
                    VStack {
                        Text("\(appTimer.formatTime(appTimer.timeRemaining))")
                            .font(Font.system(size: 32, weight: .regular, design: .serif).monospacedDigit())
                            .foregroundColor(.white)
                            .frame(height: UIScreen.main.bounds.height / 2 - 62)
                          //  .padding(.top, 124)
                        Spacer()
                    } // End Countdown Text
                    
                    if appTimer.state == .paused {
                        VStack(spacing: 8) {
                            Spacer()
                            if appTimer.timePassed >= 5 {
                                Button("Log \(appTimer.formatTime(appTimer.timePassed)) sesion") {
                                    yogi.saveSession(date: Date(), duration: appTimer.timePassed)
                                }
                            }
                            Button("Cancel") {
                                appTimer.reset()
                            }
                        }
                        .transition(.move(edge: .bottom))
                    }
                    
                    
                    
                } // End ZStack container
                
            } // End outer conditional
        }
    }
}

struct TimerControls_Previews: PreviewProvider {
    static var previews: some View {
        let appTimer = AppTimer()
        let yogi = Yogi()
        return TimerControls(showTimePicker: .constant(false))
            .environmentObject(appTimer)
            .environmentObject(yogi)
    }
}

