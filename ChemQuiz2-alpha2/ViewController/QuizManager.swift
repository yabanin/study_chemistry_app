//
//  Quiz.swift
//  StudySwiftUI
//
//  Created by Ryo Hanma on 2020/09/10.
//  Copyright © 2020 Ryo Hanma. All rights reserved.
//

import Foundation

class QuizesManager: ObservableObject {
    var quizes = [QuizModel]()
    @Published var presentQuestion: String = ""
    @Published var presantChoice = ["","","",""]
    @Published var isFinished: Bool = false
    @Published var answered: Bool  = false
    @Published var result = Result()
    @Published var questionNumber: Int = 0
    @Published var isCorrect = true
    private var timer : Timer!
    private var clear: Int = 0
    
    func prepareQuestion() {
        presentQuestion = quizes[questionNumber].question
        for i in 0 ..< quizes[questionNumber].choice.count {
            presantChoice[i] = quizes[questionNumber].choice[i]
        }
        
        if quizes[questionNumber].isShufle {
            for i in 0 ..< presantChoice.count {
                let r = Int(arc4random_uniform(UInt32(presantChoice.count)))
                presantChoice.swapAt(i, r)
            }
        }
    }
    
    func judge(_ answeredNumber: Int) {
        answered = true
        if presantChoice[answeredNumber] == quizes[questionNumber].answer {
            clear += 1
            isCorrect = true
            result.isCorrect.append(true)
        } else {
            isCorrect = false
            result.isCorrect.append(false)
        }
        questionNumber += 1
        result.answerdChoice.append(presantChoice[answeredNumber])

        startTimer()
    }
    
    func nextQuiz() {
        if questionNumber >= quizes.count {
            result.numberOfQuestion = questionNumber
            result.numberOfCorrect = clear
            result.correctRate = Float(clear) / Float(questionNumber)
            isFinished = true
        } else {
            self.prepareQuestion()
        }
    }
    
    func startTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) {
           _ in
            self.answered = false
       }
        self.nextQuiz()
    }
}
