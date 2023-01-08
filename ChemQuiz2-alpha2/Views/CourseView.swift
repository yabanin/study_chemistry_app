//
//  CourseView.swift
//  ChemQuiz-1
//
//  Created by Ryo Hanma on 2021/02/27.
//
import CoreData
import SwiftUI

var courseList: [CourseModel] = load("CourseList.json")

struct CourseView: View {
    @State var stars = 0
    @State var registed = true
    
    @Environment(\.managedObjectContext) private var context
    
    @FetchRequest(
            entity: QuizProgress.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \QuizProgress.quizName, ascending: true)],
            predicate: nil
        ) private var quizProgress: FetchedResults<QuizProgress>
    
    var body: some View {
        NavigationView {
            List {
                StarsSumView(quizProgress: quizProgress)
                ForEach (courseList) { course in
                    if (stars >=  course.requireStars) {
                        NavigationLink(
                            destination: ToLecture(course: course)
                        ) {
                            CourseListRow(course: course)
                        }
                        NavigationLink(
                            destination: ToQuiz(course: course)
                        ){
                            CourseListRowToQuiz(course: course, quizProgress: quizProgress)
                        }
                    } else {
                        InactiveCourseListRow(course: course)
                    }
                    
                }
            }.listStyle(GroupedListStyle())
            .navigationBarTitle("Course", displayMode: .inline)
            .onAppear(perform:{
            })
        }
        .onAppear(perform: {
            //setup()
        })
    }
    
    func countStar() {
        stars = quizProgress.reduce(0) {$0 + Int($1.stars)}

    }
    
    func setup() {
        let visit = UserDefaults.standard.bool(forKey: "visit")
        if visit {
            registed = false
        } else {
            UserDefaults.standard.set(true, forKey: "visit")
        }
    }
}

struct StarsSumView: View {
    @State var stars: Int = 0
    var quizProgress: FetchedResults<QuizProgress>
    
    var body: some View {
        HStack() {
            Image("ActiveStar")
                .resizable()
                .frame(width: 30, height: 30)
            Text("\(stars)").font(.title)
        }.onAppear(perform: countStar)
    }
    
    func countStar() {
        stars = quizProgress.reduce(0) {$0 + Int($1.stars)}
    }
}

struct CourseListRow: View {
    var course: CourseModel
        
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(course.name)
                    .frame(height: 40, alignment: .leading)
                    .font(.title)
                Text(course.overview)
                    .foregroundColor(Color.gray)
            }
        }
    }
}

struct CourseListRowToQuiz: View {
    var course: CourseModel
    var quizProgress: FetchedResults<QuizProgress>
    @State var lectureStars: Int = 0
    

    var body: some View {
        HStack {
            StarView(lectureStars: lectureStars)
            Spacer()
            Text("ミニクイズ")
        }.onAppear(perform: findLectureStars)
    }
    
    func findLectureStars() {
        for progress in quizProgress{
            if progress.quizName == course.quiz {
                lectureStars = Int(progress.stars)
            }
        }
    }
}

struct InactiveCourseListRow: View {
    var course: CourseModel
    var body: some View {
        HStack {
            InactiveStar()
            Text("\(course.requireStars)")
                .frame(width: 20, height: 20)
            VStack(alignment: .leading) {
                Text(course.name)
                    .font(.title)
                    .foregroundColor(.gray)
                Text(course.overview)
            }
        }
    }
}

struct StarView: View {
    var lectureStars: Int
    
    var body: some View {
        switch lectureStars {
        case 1:
            ActiveStar()
            InactiveStar()
            InactiveStar()
        case 2:
            ActiveStar()
            ActiveStar()
            InactiveStar()
        case 3:
            ActiveStar()
            ActiveStar()
            ActiveStar()
        default:
            InactiveStar()
            InactiveStar()
            InactiveStar()
        }
    }
}

struct ActiveStar: View {
    var body: some View {
        Image("ActiveStar")
            .resizable()
            .frame(width: 20, height: 20)
    }
}

struct InactiveStar: View {
    var body: some View {
        Image("InactiveStar")
            .resizable()
            .frame(width: 20, height: 20)
    }
}

struct CourceView_Previews: PreviewProvider {
    static var previews: some View {
        CourseView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
