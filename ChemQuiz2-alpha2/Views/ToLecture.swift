//
//  ToLecture.swift
//  ChemQuiz2-alpha2
//
//  Created by Ryo Hanma on 2021/10/18.
//

import Foundation
import SwiftUI

struct ToLecture: View {
    var course: CourseModel
    @State var isShowQuiz = false

    var body: some View {
        if isShowQuiz {
            QuizView(cource: course)
        } else {
            LectureView(course: course, isShowQuiz: $isShowQuiz)
        }
    }
}
