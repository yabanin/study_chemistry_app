//
//  ToQuiz.swift
//  ChemQuiz2-alpha2
//
//  Created by Ryo Hanma on 2021/09/30.
//

import SwiftUI

struct ToQuiz: View {
    var course: CourseModel

    var body: some View {
        QuizView(cource: course)
    }
}
