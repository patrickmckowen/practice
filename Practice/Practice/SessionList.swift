//
//  SessionList.swift
//  Practice
//
//  Created by Patrick McKowen on 9/17/20.
//

import SwiftUI

struct SessionList: View {
    @EnvironmentObject var yogi: Yogi
    @EnvironmentObject var appTimer: AppTimer
    
    var body: some View {
        // Session List
        VStack(alignment: .leading) {
            Text("Sessions")
                .font(.headline)
                .padding(.bottom, 8)
            
            ForEach(yogi.sessions.reversed()) { session in
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(session.date, formatter: itemFormatter)")
                    Text("\(session.duration, specifier: "%.f") seconds")
                        .foregroundColor(.gray)
                    Divider()
                        .padding(.vertical, 8)
                }
            }
            
            Spacer()
        }
        .padding(16)
    }
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter
    }()
}

struct SessionList_Previews: PreviewProvider {
    static var previews: some View {
        let appTimer = AppTimer()
        let yogi = Yogi()
        return SessionList()
            .environmentObject(appTimer)
            .environmentObject(yogi)
    }
}

