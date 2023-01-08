//
//  LectureModel.swift
//  ChemQuiz2-alpha2
//
//  Created by Ryo Hanma on 2021/10/03.
//

import Foundation

struct LecturePage: Codable, Hashable {
    var page: [LectureModel]
}

struct LectureModel: Codable, Hashable {
    var contentType: String
    var content: String
}
