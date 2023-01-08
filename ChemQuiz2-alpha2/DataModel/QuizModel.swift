//
//  QuizModel.swift
//  ChemQuiz-1
//
//  Created by Ryo Hanma on 2021/03/02.
//

import Foundation

class QuizModel: Codable, ObservableObject {
    var question: String
    var answer: String
    var choice: [String]
    var isShufle: Bool
}

class Result: ObservableObject {
    @Published var quizName: String = ""
    @Published var numberOfQuestion: Int = 0
    @Published var numberOfCorrect: Int = 0
    @Published var correctRate: Float = 0
    @Published var answerdChoice = [String]()
    @Published var isCorrect = [Bool]()
}
