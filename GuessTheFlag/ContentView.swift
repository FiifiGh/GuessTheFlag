//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by KOFI on 8/12/20.
//  Copyright © 2020 fiifi_gh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private  var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
     @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle   = ""
    @State private var score        = 0
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            VStack{
                Text("Tap the flag of").foregroundColor(Color.white)
                Text(countries[correctAnswer]).foregroundColor(Color.white).font(.largeTitle).fontWeight(.black)
                
                VStack(spacing: 30){
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            self.flagTapped(number)
                        }){
                            Image(self.countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(color: .black, radius: 2)
                        }
                    }
                    
                    Text("Points : \(score)").foregroundColor(Color.white).font(.title)
                }
                
                Spacer()
            }
            
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
        
        
    }
    
    
    func flagTapped(_ number : Int)  {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong you selected \(countries[number])"
        }

        showingScore.toggle()
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
