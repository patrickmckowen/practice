//
//  AppleHealthPromo.swift
//  Practice
//
//  Created by Patrick McKowen on 9/29/20.
//

import SwiftUI

struct AppleHealthPromo: View {
    @EnvironmentObject var yogi: Yogi
    
    var body: some View {
        VStack(spacing: 0) {
            Image("Icon - Apple Health")
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .padding(.bottom, 16)
            Text("Mindful Minutes")
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.black.opacity(0.7))
                .padding(.bottom, 8)
            Text("Automatically save your meditation sessions with Apple Health.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.black.opacity(0.5))
                .padding(.bottom, 24)
            Button("Sync with Apple Health") {
                yogi.activateHealthKit()
                UserDefaults.standard.set(true, forKey: "AppleHealthIsOn")
            }
            .buttonStyle(ButtonLightSmall())
            .padding(.bottom, 16)
            Button("Skip for now") {
                UserDefaults.standard.set(false, forKey: "AppleHealthIsOn")
                UserDefaults.standard.set(false, forKey: "ShowAppleHealthPromo")
            }
            .foregroundColor(Color.black.opacity(0.6))
        }
        .padding(32)
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.03))
    }
}

struct AppleHealthPromo_Previews: PreviewProvider {
    static var previews: some View {
        let yogi = Yogi()
        return AppleHealthPromo()
            .environmentObject(yogi)
    }
}
