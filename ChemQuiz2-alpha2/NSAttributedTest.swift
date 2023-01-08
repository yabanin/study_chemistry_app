//
//  NSAttributedTest.swift
//  ChemQuiz2-alpha2
//
//  Created by Ryo Hanma on 2021/07/02.
//

import SwiftUI
import Foundation

extension NSAttributedString {
    static func parseHTMLtoText(sourceText text: String) -> NSAttributedString {
        var htmlCSSString = ""
        if UITraitCollection.isDarkMode {
            htmlCSSString = "<style>" +
                        "*" +
                        "{" +
                        "font-size: \(12)pt;" +
                        "font-family: Helvetica;color:#FFFFFF" +
                        "}b {color: #3da9fc}h1{font-size: 18pt}h2{font-size: 16pt}h3{color: #fffffe;}</style>" +
                        "</script>"
        } else {
            htmlCSSString = "<style>" +
                        "*" +
                        "{" +
                        "font-size: \(12)pt;" +
                        "font-family: Helvetica;background-color: white;" +
                        "}b {color: #094067}h1{font-size: 18pt}h2{font-size: 16pt}h3{color: #094067}</style>" +
                        "</script>"
        }
        
        let cssText = htmlCSSString + text
        let encodeData = cssText.data(using: String.Encoding.unicode, allowLossyConversion: true)
        
        var attributedString =  NSAttributedString()
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
                NSAttributedString.DocumentType.html]
              
        if let encodeData = encodeData {
            do {
                attributedString = try NSAttributedString(
                    data: encodeData,
                    options: options,
                    documentAttributes: nil
                )
            } catch {
                print("Couldn't load \(encodeData)\n")
            }
        }

        return attributedString
    }
}

extension UIImage {
    func resize(scale: CGFloat) -> UIImage? {
        let newSize = CGSize(width: self.size.width*scale, height: self.size.height*scale)
            let rect = CGRect(origin: CGPoint.zero, size: newSize)

            UIGraphicsBeginImageContext(newSize)
            self.draw(in: rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        return newImage!
    }
}

extension UITraitCollection {
    public static var isDarkMode: Bool {
        if #available(iOS 13, *), current.userInterfaceStyle == .dark {
            return true
        }
        return false
    }

}
