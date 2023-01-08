//
//  LectureView.swift
//  ChemQuiz-2
//
//  Created by Ryo Hanma on 2021/05/05.
//

import SwiftUI

struct LectureView: View {
    var course: CourseModel
    @Binding var isShowQuiz: Bool
    @ObservedObject var lectureManager = LectureManager()
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        TabView {
            ForEach(lectureManager.passages, id: \.self) {passage in
                LecturePageView(page: passage)
            }
            if course.quiz != "" {
                Button(action: {
                    self.isShowQuiz.toggle()
                }) {
                    ToQuizButton()
                }
            } else {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    BackToCourseButton()
                }
            }
        }
        .id(lectureManager.passages.hashValue)
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .onAppear(perform: {
            loadLecture()
        })
        BannerAdView().frame(width: 320, height: 50)
    }
    
    struct ToQuizButton: View {
        var body: some View {
            Text("   演習に進む   ")
                .padding()
                .foregroundColor(.white)
                .background(Color(red: 61/255, green: 169/255, blue: 252/255))
                .cornerRadius(25)
                .shadow(radius: 5)
        }
    }
    
    struct BackToCourseButton: View {
        var body: some View {
            Text("  コース選択画面に戻る   ")
                .padding()
                .foregroundColor(.white)
                .background(Color(red: 61/255, green: 169/255, blue: 252/255))
                .cornerRadius(25)
                .shadow(radius: 5)
        }
    }
    
    func loadLecture() {
        lectureManager.loadLecture(lecture: course.lecture)
    }
}

struct LecturePageView: View {
    var page: LecturePage
    
    var body: some View {
        VStack() {
            ForEach(0..<page.page.count) {i in
                if page.page[i].contentType == "text" {
                    TextView(text: page.page[i].content)
                }
                if page.page[i].contentType == "image" {
                    ImageView(imageName: page.page[i].content)
                }
            }
        }
    }
}
