//
//  TriviaGameView.swift
//  Project 5
//
//  Created by christian de angelo orozco on 11/4/24.
//

import SwiftUI

struct TriviaGameView: View {
    @ObservedObject var viewModel: TriviaViewModel
    let numberOfQuestions: Int
    let category: String
    let difficulty: String
    let questionType: String
    let timerDuration: Int
    
    @State private var selectedAnswers: [UUID: String] = [:]
    @State private var timeRemaining: Int
    @State private var timer: Timer?
    @State private var showScore = false
    
    init(viewModel: TriviaViewModel, numberOfQuestions: Int, category: String, difficulty: String, questionType: String, timerDuration: Int) {
        self.viewModel = viewModel
        self.numberOfQuestions = numberOfQuestions
        self.category = category
        self.difficulty = difficulty
        self.questionType = questionType
        self.timerDuration = timerDuration
        _timeRemaining = State(initialValue: timerDuration)
    }
    
    var body: some View {
        VStack {
            if showScore {
                ScoreView(score: calculateScore(), playAgainAction: resetGame)
            } else {
                Text("Time Remaining: \(timeRemaining)")
                    .font(.headline)
                    .padding()
                    .onAppear(perform: startTimer)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.questions) { question in
                            VStack(alignment: .leading) {
                                Text(question.question)
                                    .font(.headline)
                                    .padding(.bottom, 5)
                                
                                ForEach(question.shuffledAnswers, id: \.self) { answer in
                                    Button(action: {
                                        selectedAnswers[question.id] = answer
                                    }) {
                                        Text(answer)
                                            .font(.body)
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(selectedAnswers[question.id] == answer ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                                            )
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(selectedAnswers[question.id] == answer ? Color.blue : Color.gray, lineWidth: 1)
                                            )
                                            .foregroundColor(.primary)
                                    }
                                    .padding(.vertical, 2)
                                }
                                Divider()
                            }
                            .padding(.vertical, 10)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Button("Submit Answers") {
                    submitAnswers()
                }
                .padding()
                .font(.headline)
            }
        }
        .onAppear {
            viewModel.fetchTriviaQuestions(number: numberOfQuestions, category: category, difficulty: difficulty, type: questionType)
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        timeRemaining = timerDuration
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                submitAnswers()
            }
        }
    }
    
    func submitAnswers() {
        timer?.invalidate()
        showScore = true
    }
    
    func resetGame() {
        // Reset state for a new game
        showScore = false
        selectedAnswers = [:]
        timeRemaining = timerDuration
        viewModel.fetchTriviaQuestions(number: numberOfQuestions, category: category, difficulty: difficulty, type: questionType)
        startTimer()  // Restart the timer for the new game
    }
    
    func calculateScore() -> Int {
        var score = 0
        for question in viewModel.questions {
            if selectedAnswers[question.id] == question.correct_answer {
                score += 1
            }
        }
        return score
    }
}




