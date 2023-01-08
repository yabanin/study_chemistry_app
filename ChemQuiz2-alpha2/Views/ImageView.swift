//
//  ImageVIew.swift
//  ChemQuiz2-alpha2
//
//  Created by Ryo Hanma on 2021/09/30.
//

import SwiftUI

struct ImageView: View {
    var imageName: String
    @State var isPressed = false
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .onTapGesture {
                self.isPressed.toggle()
            }
    }

}

struct ModalImageView: View {
    @Binding var isModalActive: Bool
    @State var scaleValue: CGFloat = 1.0
    
    var body: some View {
        VStack {
            Button("×"){
                isModalActive.toggle()
            }
            .frame(maxWidth: .infinity, alignment: .topTrailing)
            .foregroundColor(.gray)
            .padding(10)
            Image("periodic table")
                .resizable()
                .scaledToFit()
                .scaleEffect(scaleValue)
                .gesture(MagnificationGesture()
                            .onChanged { value in
                                self.scaleValue = value
                            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}
