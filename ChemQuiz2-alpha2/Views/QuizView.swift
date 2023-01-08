//
//  QuizView.swift
//  ChemQuiz-2
//
//  Created by Ryo Hanma on 2021/05/05.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject var quiz = QuizesManager()
    var cource: CourseModel
        
    var body: some View {
        if self.quiz.isFinished {
            ResultView(review: quiz, course: cource)
        } else {
            ZStack {
                VStack {
                    Text("No.\(quiz.questionNumber + 1)/\(quiz.quizes.count)")
                        .foregroundColor(Color(red: 95/255, green: 108/255, blue: 123/255))
                    Spacer()
                    ZStack {
                        Text(quiz.presentQuestion).font(.title)
                    }
                    Spacer()
                    ForEach( 0..<4) { i in
                        Button(action: {
                            quiz.judge(i)
                        }){
                            ButtonText(buttonNumber: i, choice: $quiz.presantChoice[i])
                        }
                        .frame(width: UIScreen.main.bounds.width - 10, height: 50)
                        .disabled(quiz.isFinished || quiz.answered)
                        .background(Color.white)
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color(red: 9/255, green: 64/255, blue: 103/255), lineWidth: 4)
                        )
                        .padding(2)
                    }
                    BannerAdView().frame(width: 320, height: 50)
                }
                if quiz.answered {
                    if quiz.isCorrect {
                        CircleView()
                    } else {
                        BatsuView()
                    }
                    
                }
            }
            .onAppear(perform: {
                loadQuiz()
                self.quiz.prepareQuestion()
            })
        }
    }
    
    func loadQuiz() {
        quiz.quizes = load(cource.quiz)
    }
}

struct ButtonText: View {
    var buttonNumber: Int
    @Binding var choice: String
    
    var body: some View {
        HStack {
            Text("   \(buttonNumber + 1).")
                .foregroundColor(Color.gray)
                .frame(width: 50, height: 50)
            Text(choice)
                .foregroundColor(Color(red: 9/255, green: 64/255, blue: 103/255))
                .frame(width: UIScreen.main.bounds.width - 60, height: 50, alignment: .leading)
        }
    }
}

struct CircleView: View {
    var body: some View {
        Path { path in
            path.addArc(
                center: CGPoint(x: 100, y: 100),
                radius: 100,
                startAngle: .degrees(0),
                endAngle: .degrees(360),
                clockwise: false
            )
            path.closeSubpath()
        }
        .stroke(lineWidth: 20)
        .fill(Color.green.opacity(0.8))
        .frame(width: 200, height: 200)
    }
}


struct BatsuView: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 200, y: 200))
            path.move(to: CGPoint(x: 200, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 200))
        }
        .stroke(lineWidth: 20)
        .fill(Color.red.opacity(0.8))
        .frame(width: 200, height: 200)
    }
}


struct Quiz_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
    }
}
