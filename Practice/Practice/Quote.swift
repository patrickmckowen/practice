//
//  Quote.swift
//  Practice
//
//  Created by Patrick McKowen on 9/28/20.
//

import SwiftUI

struct Quote: View {
    let quote = "Meditation doesn't change life. Life remains as fragile and unpredictable as ever. Meditation changes the heart's capacity to accept life as it is."
    let author = "Sylvia Boorstein"
    
    let gradient = LinearGradient(gradient:Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.6078431373, blue: 0.4509803922, alpha: 1)), Color(#colorLiteral(red: 0.4901960784, green: 0.4196078431, blue: 0.8980392157, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    
    @State var isVisible = true
    @State var animateText = false
    @State var animateImage = false
    
    var body: some View {
        ZStack {
            VStack {
                Text("“")
                    .frame(maxHeight: 124)
                    .font(.system(size: 124, weight: .bold, design: .serif))
                    .foregroundColor(Color(#colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)))
                    .padding(.bottom, -64)
                    .padding(.leading, -2)
                    .foregroundMask(gradient)
                Text("TODAY'S MINDFUL MOMENT")
                    .kerning(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    .font(.footnote)
                    .foregroundColor(Color(#colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)))
                    .padding(.bottom, 1)
                Text("by \(author.uppercased())")
                    .kerning(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    .font(.footnote)
                    .foregroundColor(Color(#colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)))
                
                Spacer()
            }
            .opacity(isVisible ? 1.0 : 0.0)
            .offset(y: isVisible ? 0 : -100)
            
            // Quote
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                Text("\(quote)")
                    .font(.system(size: 32, weight: .regular, design: .serif))
                    .lineSpacing(10)
                    .foregroundColor(Color(#colorLiteral(red: 0.3019607843, green: 0.3019607843, blue: 0.3019607843, alpha: 1)).opacity(!isVisible ? 0.0 : 1.0))
                    .scaleEffect(!isVisible ? 10 : 1)
                
                Spacer()
            } // End Quote
            .padding(.horizontal, 32)
            
            // Button
            VStack(spacing: 0) {
                Spacer()
                Button("Continue") {
                    withAnimation(Animation.spring()) {
                        isVisible.toggle()
                    }
                    
                    withAnimation(Animation.easeOut(duration: 10.0).delay(2)) {
                        animateText.toggle()
                    }
                    
                    withAnimation(Animation.easeOut(duration: 4.0).delay(4)) {
                        animateImage.toggle()
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 56)
                .background(Color.black.opacity(0.04))
                .cornerRadius(8)
                .foregroundColor(.black)
                .padding(.horizontal, 32)
                
            }
            .padding(.bottom, 16)
            .opacity(isVisible ? 1.0 : 0.0)
            .offset(y: isVisible ? 0 : 100)
        }
        .background(Image("default").opacity(animateImage ? 1.0 : 0.0).edgesIgnoringSafeArea(.all))
    }
}

struct Quote_Previews: PreviewProvider {
    static var previews: some View {
        Quote()
    }
}
