//
//  OptionsView.swift
//  Project 5
//
//  Created by christian de angelo orozco on 11/4/24.
//

import SwiftUI

struct OptionsView: View {
    @State private var numberOfQuestions = 10
    @State private var category = "9"  // Default to General Knowledge
    @State private var difficulty = "easy"
    @State private var questionType = "multiple"
    @State private var timerDuration: Double = 30  // Timer duration setting

    var body: some View {
        NavigationView {
            Form {
                Stepper(value: $numberOfQuestions, in: 5...20) {
                    Text("Number of Questions: \(numberOfQuestions)")
                }
                
                Picker("Category", selection: $category) {
                    Text("General Knowledge").tag("9")
                    Text("Science & Nature").tag("17")
                    Text("Sports").tag("21")
                    // Add more categories with appropriate IDs
                }
                
                Picker("Difficulty", selection: $difficulty) {
                    Text("Easy").tag("easy")
                    Text("Medium").tag("medium")
                    Text("Hard").tag("hard")
                }
                
                Picker("Type", selection: $questionType) {
                    Text("Multiple Choice").tag("multiple")
                    Text("True/False").tag("boolean")
                }
                
                VStack {
                    Text("Timer Duration: \(Int(timerDuration)) seconds")
                    Slider(value: $timerDuration, in: 10...60, step: 5)
                }
                
                NavigationLink(
                    destination: TriviaGameView(
                        viewModel: TriviaViewModel(),
                        numberOfQuestions: numberOfQuestions,
                        category: category,
                        difficulty: difficulty,
                        questionType: questionType,
                        timerDuration: Int(timerDuration)
                    )
                ) {
                    Text("Start Game")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Trivia Options")
        }
    }
}

