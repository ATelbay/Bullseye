//
//  AboutView.swift
//  Bullseye
//
//  Created by Arystan on 9/5/20.
//  Copyright © 2020 Arystan Telbay. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    
    let backgroundColor = Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0)
    
    struct HeadlineTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 30).bold())
                .padding(.vertical, 20)
        }
    }
    
    struct TextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 16).bold())
                .padding(.horizontal, 60)
                .padding(.bottom, 20)
                .multilineTextAlignment(TextAlignment.center)
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content.shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bullseye 🎯").modifier(HeadlineTextStyle())
                Text("This is Bulleye. The game where you can earn a fame by dragging a slider").modifier(TextStyle())
                Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points your score").modifier(TextStyle())
                Text("Enjoy!").modifier(TextStyle())
            }
            .background(Image("PaperBackground").resizable().modifier(Shadow()))
            .navigationBarTitle("About Bullseye")
        }
        .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
