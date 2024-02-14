//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Zakir Ufuk Sahiner on 01.02.24.
//
// 100 Days of SwiftUI Project 2

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var gameFinish = false
    @State private var scoreTitle = ""
    @State private var score: Int = 0
    @State private var questionCount = 0
    
    var body: some View {
        ZStack {
            background
            VStack{
                Spacer()
                title
                questionSection
                Spacer()
                Spacer()
                scoreText
                Spacer()
            }
            .padding()
        }
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askNewQuestion)
        } message: {
            if scoreTitle == "Correct" {
                Text ("Your score is: \(score) /8")
            } else {
                Text ("That’s the flag of \(countries[correctAnswer])")
            }
        }
        .alert("You have finished the game with \(score) out of 8 points", isPresented: $gameFinish) {
            Button("Start again", action: gameFinished)
        } message: {}
    }
    
    //MARK: Functions
    func flagTapped(_ number: Int) {
        if questionCount == 8 {
            gameFinish = true
        }else if number == correctAnswer {
            score += 1
            questionCount += 1
            scoreTitle = "Correct"
        } else {
            questionCount += 1
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    func askNewQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func gameFinished() {
        score = 0
        askNewQuestion()
    }
    
    //MARK: Views
    var title: some View {
        Text("Guess the Flag")
            .font(.largeTitle.bold())
            .foregroundStyle(.white)
    }
    var scoreText: some View {
        Text("Score: \(score) / 8")
            .foregroundStyle(.white)
            .font(.title.bold())
    }
    
    var questionSection: some View {
        VStack (spacing: 15){
            VStack {
                Text("Tap the flag of")
                    .foregroundStyle(.secondary)
                    .font(.subheadline.weight(.heavy))
                
                Text(countries[correctAnswer])
                    .font(.largeTitle.weight(.semibold))
            }
            ForEach(0..<3) { number in
                Button {
                    flagTapped(number)
                } label: {
                    Image(countries[number])
                        .clipShape(.capsule)
                        .shadow(radius: 5)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 60))
    }
    
    var background: some View {
        RadialGradient(stops: [
            .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
            .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
        ], center: .top, startRadius: 200, endRadius: 700)
        .ignoresSafeArea()
    }
    
}

#Preview {
    ContentView()
}
