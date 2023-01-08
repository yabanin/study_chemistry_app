//
//  Result.swift
//  StudySwiftUI
//
//  Created by Ryo Hanma on 2020/09/12.
//  Copyright © 2020 Ryo Hanma. All rights reserved.
//

import SwiftUI

struct ResultView: View {
    var review: QuizesManager
    var course: CourseModel
    
    var body: some View {
        List {
            if review.result.correctRate >= 0.5 {
                PassView(course: course, correctRate: review.result.correctRate)
            }
            Section(header: Text("正解数")) {
                Text("\(review.result.numberOfCorrect)/\(review.result.numberOfQuestion)")
                Text("\(Int(round(review.result.correctRate * 100)))%")
            }
            Section(header: Text("間違えた問題")) {
                ForEach(0..<review.result.numberOfQuestion, id: \.self) { i in
                    if (review.result.isCorrect[i] == false) {
                        ReviewItem(question: review.quizes[i].question, answer: review.quizes[i].answer)
                            .padding(5)
                    }
                }
            }
        }.listStyle(GroupedListStyle())
        .onAppear(perform: loadReviewData)
    }
    
    func loadReviewData() {
        review.quizes = load(course.quiz)
    }
}

struct PassView: View {
    @Environment(\.managedObjectContext) private var context
    
    @FetchRequest(
            entity: QuizProgress.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \QuizProgress.quizName, ascending: true)],
            predicate: nil
        ) var quizProgress: FetchedResults<QuizProgress>

    var course: CourseModel
    var correctRate: Float
    
    var body: some View {
        Text("合格(正解率50%以上)")
            .onAppear(perform: addStar)
    }
    
    func addStar() {
        var stars = 1
        if correctRate >= 0.7 {
            stars = 2
        }
        if correctRate == 1 {
            stars = 3
        }
        
        var existProgress = false
        
        for progress in quizProgress {
            if progress.quizName == course.quiz {
                existProgress = true
                if stars >= progress.stars {
                    progress.stars = Int16(stars)
                }
            }
        }
        
        if !existProgress {
            let newQuizProgress = QuizProgress(context: context)
            newQuizProgress.quizName = course.quiz
            newQuizProgress.stars = Int16(stars)
        }
        
        try? context.save()
    }
}

struct ReviewItem: View{
    var question: String
    var answer: String
    
    var body: some View {
        VStack {
            Text(question)
            Text(answer)
        }
    }
}

struct Result_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello")
    }
}
