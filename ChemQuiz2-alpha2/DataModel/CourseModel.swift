//
//  Lecture.swift
//  StudySwiftUI
//
//  Created by Ryo Hanma on 2020/09/10.
//  Copyright © 2020 Ryo Hanma. All rights reserved.
//
import Foundation

struct CourseModel: Identifiable, Codable {
    let id: Int
    let name: String
    let overview: String
    let lecture: String
    var quiz: String
    var category: Category
    var requireStars: Int
    
    enum Category: String, CaseIterable, Codable, Hashable {
        case others = "others"
        case basic = "basic"
        case theory = "theory"
        case inorganic = "inorganic"
        case organic = "organic"
    }
}
