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

struct ButtonLightSmall: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(.black)
            .padding(.horizontal, 32)
            .frame(height: 48)
            .background(Color.white)
            .cornerRadius(8)
             .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1)), radius:4, x:0, y:0)
           //  .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15)), radius:8, x:0, y:2)
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

// Foreground Mask
extension View {
    public func foregroundMask<Overlay: View>(_ overlay: Overlay) -> some View {
        _CustomForeground(overlay: overlay, for: self)
    }
}

private struct _CustomForeground<Content: View, Overlay: View>: View {
    let content: Content
    let overlay: Overlay
    
    internal init(overlay: Overlay, for content: Content) {
        self.content = content
        self.overlay = overlay
    }
    
    var body: some View {
        content.overlay(overlay).mask(content)
    }
}

