//
//  TriviaModel.swift
//  Project 5
//
//  Created by christian de angelo orozco on 11/4/24.
//

import Foundation

struct TriviaQuestion: Codable, Identifiable {
    let id = UUID()  // Unique ID for SwiftUI
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
    let type: String  // For distinguishing multiple choice or true/false
    
    // Stored property for answers, shuffled once during initialization
    let shuffledAnswers: [String]
    
    // Custom initializer to shuffle answers once
    init(question: String, correct_answer: String, incorrect_answers: [String], type: String) {
        self.question = question
        self.correct_answer = correct_answer
        self.incorrect_answers = incorrect_answers
        self.type = type
        self.shuffledAnswers = ([correct_answer] + incorrect_answers).shuffled() // Shuffle once
    }
}

// Update TriviaResponse to use the custom initializer when decoding
struct TriviaResponse: Codable {
    let results: [TriviaQuestion]
    
    // Custom decoding to apply our custom initializer to each question
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let decodedQuestions = try container.decode([DecodedTriviaQuestion].self, forKey: .results)
        
        // Convert decoded trivia questions into TriviaQuestion instances with shuffled answers
        self.results = decodedQuestions.map {
            TriviaQuestion(question: $0.question,
                           correct_answer: $0.correct_answer,
                           incorrect_answers: $0.incorrect_answers,
                           type: $0.type)
        }
    }
    
    private struct DecodedTriviaQuestion: Codable {
        let question: String
        let correct_answer: String
        let incorrect_answers: [String]
        let type: String
    }
}






