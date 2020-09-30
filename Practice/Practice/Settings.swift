//
//  Settings.swift
//  Practice
//
//  Created by Patrick McKowen on 9/28/20.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var yogi: Yogi
    @EnvironmentObject var appTimer: AppTimer
    
    @Environment(\.presentationMode) var mode
    
    @State var appleHealthIsOn = UserDefaults.standard.bool(forKey: "AppleHealthIsOn")
    //   @State var remindersIsOn = UserDefaults.standard.bool(forKey: "Reminders")
    
    var body: some View {
        ZStack {
            // Settings
            // TODO: // Add DatePicker to select prefered time
            VStack {
                Text("Settings")
                    .font(.system(size: 18, weight: .semibold, design: .serif))
                    .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)))
                    .padding(.vertical, 16)
                
                // Apple Health
                Toggle(isOn: $appleHealthIsOn) {
                    // Text
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Mindful Minutes")
                            .font(.body)
                            .padding(.bottom, 4)
                            .padding(.top, 12)
                        
                        Text("Automatically sync your meditation sessions with Apple Health.")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.trailing, 4)
                            .padding(.bottom, 12)
                    }
                    .foregroundColor(.black)
                }
                .onChange(of: appleHealthIsOn) { _ in
                    yogi.activateHealthKit()
                    UserDefaults.standard.set(appleHealthIsOn, forKey: "AppleHealthIsOn")
                    UserDefaults.standard.set(false, forKey: "ShowAppleHealthPromo")
                }
                .padding(.horizontal, 24)
                // end Apple Health
                
                
                
                /*
                 // TODO: Add Notifications
                 // Divider
                 Rectangle()
                 .frame(maxWidth: .infinity, maxHeight: 1)
                 .foregroundColor(Color.black.opacity(0.1))
                 .padding(.leading, 32)
                 
                 // Reminders
                 Toggle(isOn: $remindersIsOn) {
                 // Text
                 VStack(alignment: .leading) {
                 Text("Reminders")
                 .font(.body)
                 .padding(.vertical, 12)
                 }
                 .foregroundColor(.black)
                 }
                 .padding(.horizontal, 24)
                 // end Reminders Toggle
                 */
                
                Spacer()
                
            } // end Settings VStack container
            
            
            // Back Button
            Image(systemName: "chevron.left")
                .position(x: 8, y: 0)
                .font(.system(size: 20))
                .foregroundColor(.black)
                .padding(.horizontal, 24)
                .padding(.top, 24)
                .onTapGesture {
                    self.mode.wrappedValue.dismiss()
                }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        let appTimer = AppTimer()
        let yogi = Yogi()
        return Settings()
            .environmentObject(appTimer)
            .environmentObject(yogi)
    }
}
