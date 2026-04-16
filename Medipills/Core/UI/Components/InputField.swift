//
//  SwiftUIView.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 25/04/2025.
//

import SwiftUI


struct InputField: View {
    let iconName: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundStyle(.grayMed)
            if isSecure {
                SecureField(placeholder, text: $text)
                    .font(.custom("Manrope-Light", size: 12))
            } else {
                TextField(placeholder, text: $text)
                    .font(.custom("Manrope-Light", size: 12))
            }
        }
        .padding()
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(.clearGray, lineWidth: 1)
        )
        .cornerRadius(25)
        .padding(.horizontal, 10)
        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
    }
}


