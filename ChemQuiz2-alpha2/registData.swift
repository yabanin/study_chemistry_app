//
//  registData.swift
//  ChemQuiz2-alpha2
//
//  Created by Ryo Hanma on 2021/10/11.
//

import Foundation
import CoreData

func registSampleData(context: NSManagedObjectContext) {
    /// Studentテーブル全消去
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
    fetchRequest.entity = QuizProgress.entity()
    let progresses = try? context.fetch(fetchRequest) as? [QuizProgress]
    for progress in progresses! {
        context.delete(progress)
    }
    
    /// コミット
    try? context.save()
}

