//
//  LectureModel.swift
//  ChemQuiz-2
//
//  Created by Ryo Hanma on 2021/05/05.
//

import SwiftUI

class LectureManager: ObservableObject {
    @Published var passages = [LecturePage]()
    
    func loadLecture(lecture: String) {
        passages = load(lecture)
    }
}
