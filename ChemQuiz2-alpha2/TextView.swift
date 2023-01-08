//
//  TextView.swift
//  ChemQuiz2-alpha2
//
//  Created by Ryo Hanma on 2021/07/02.
//

import SwiftUI

struct TextView: UIViewRepresentable{
    var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        DispatchQueue.main.async {
            let attributedString = NSAttributedString.parseHTMLtoText(sourceText: text)
            view.attributedText = attributedString
        }

        view.isEditable = false
        view.isSelectable = true
        view.isUserInteractionEnabled = true

        return view
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
    }
}
