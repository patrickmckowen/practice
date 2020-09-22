//
//  Styles.swift
//  Practice
//
//  Created by Patrick McKowen on 9/17/20.
//

import SwiftUI

struct ButtonLight: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.black)
            .frame(width: UIScreen.main.bounds.width - 32, height: 56)
            .background(Color.white)
            .cornerRadius(8)
             .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1)), radius:2, x:0, y:0)
             .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15)), radius:8, x:0, y:2)
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

