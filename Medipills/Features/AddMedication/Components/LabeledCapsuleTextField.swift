//
//  LabeledCapsuleTextField.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 05/02/2026.
//

import Foundation
import SwiftUI

struct LabeledCapsuleTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.custom("Inter", size: 16))
                .foregroundColor(.dimGrey)
                .padding(.horizontal)

            TextField(placeholder, text: $text)
                .padding()
                .background(Color.white)
                .clipShape(Capsule())
                .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
        }
        .padding()
    }
}
