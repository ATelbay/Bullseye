//
//  ContentView.swift
//  Bullseye
//
//  Created by Arystan on 9/1/20.
//  Copyright © 2020 Arystan Telbay. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var totalScore = 0
    @State var roundNumber = 1
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 152.0 / 255.0)
    
    struct ButtonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .background(Image("Button"))
                .font(Font.custom("Arial Rounded MT Bold", size: 12).bold())
                .modifier(Shadow())
            
        }
    }
    
    struct ButtonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .background(Image("Button"))
                .font(Font.custom("Arial Rounded MT Bold", size: 18).bold())
                .modifier(Shadow())
            
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .font(Font.custom("Arial Rounded MT Bold", size: 24).bold())
                .modifier(Shadow())
            
        }
    }
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.white)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
                .modifier(Shadow())
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content.shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Text("Put the bullseye as close as you can to:")
                    .modifier(LabelStyle())
                Text("\(target)")
                    .modifier(ValueStyle())
            }
            Spacer()
            
            HStack {
                Text("1")
                    .modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100)
                    .accentColor(Color.green)
                Text("100")
                    .modifier(LabelStyle())
            }
            Spacer()
            
            Button(action: {
                print("Button clicked")
                self.alertIsVisible = true
            }) {
                Text("Hit Me")
            }
            .modifier(ButtonLargeTextStyle())
            .alert(isPresented: $alertIsVisible) { () -> Alert in hitAlert()
            }
            Spacer()
            
            HStack() {
                Button(action: {
                    self.restartRound()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start Over")
                    }
                }
                .modifier(ButtonSmallTextStyle())
                Spacer()
                
                Text("Score: ")
                    .modifier(LabelStyle())
                Text("\(totalScore)")
                    .modifier(ValueStyle())
                Spacer()
                
                Text("Round:")
                    .modifier(LabelStyle())
                Text("\(roundNumber)")
                    .modifier(ValueStyle())
                Spacer()
                
                NavigationLink(destination: AboutView()) {
                    HStack {
                        Image("InfoIcon")
                        Text("Info")
                    }
                }
                .modifier(ButtonSmallTextStyle())
            }.padding(.bottom, 20)
        }
        .accentColor(midnightBlue)
        .background(Image("Background"))
        .navigationBarTitle("Bullseye")
    }
    
    func currentRoundPoints() -> Int {
        let points = 100 - abs(target - sliderRoundedValue())
        return points
    }
    
    func bonusRoundPoints() -> Int {
        let bonusPointsDivider = 101 - currentRoundPoints()
        if (bonusPointsDivider <= 2) {
            let bonusPoints = 100 / bonusPointsDivider
            return bonusPoints
        }
        return 0
    }
    
    func alertTitle() -> String {
        let title: String
        let difference = abs(target - sliderRoundedValue())
        switch difference {
        case ...10:
            title = "Awesome"
        case ...25:
            title = "Not bad"
        case ...50:
            title = "You can do better"
        default:
            title = "Are you even trying?"
        }
        return title
    }
    
    func sliderRoundedValue() -> Int {
        return Int(sliderValue.rounded())
    }
    
    func updateRound() {
        let totalPoints = currentRoundPoints() + bonusRoundPoints()
        totalScore += totalPoints
        roundNumber += 1
        target = Int.random(in: 1...100)
    }
    
    func restartRound() {
        totalScore = 0
        roundNumber = 1
        target = Int.random(in: 1...100)
    }
    
    func hitAlert() -> Alert {
        var alertMessageText = "You scored \(currentRoundPoints())"
        if (bonusRoundPoints() > 0) {
            let totalPoints = currentRoundPoints() + bonusRoundPoints()
            alertMessageText += " and got \(bonusRoundPoints()) bonus points for accuracy.\nTotal score is \(totalPoints)"
        }
        return Alert(title: Text("\(alertTitle())"),
                     message: Text(
                        "The slider's value is \(sliderRoundedValue()) \n" +
                        alertMessageText),
                     dismissButton: .default(Text("Next round")) {
                        self.updateRound()
            })
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().previewLayout(.fixed(width: 896, height: 414))
        }
    }
}

