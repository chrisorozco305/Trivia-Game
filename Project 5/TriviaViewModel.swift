//
//  TriviaViewModel.swift
//  Project 5
//
//  Created by christian de angelo orozco on 11/4/24.
//

import Foundation
import Combine

class TriviaViewModel: ObservableObject {
    @Published var questions: [TriviaQuestion] = []
    
    func fetchTriviaQuestions(number: Int, category: String, difficulty: String, type: String) {
        let urlString = "https://opentdb.com/api.php?amount=\(number)&category=\(category)&difficulty=\(difficulty)&type=\(type)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let triviaResponse = try? decoder.decode(TriviaResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.questions = triviaResponse.results
                    }
                }
            }
        }.resume()
    }
}


