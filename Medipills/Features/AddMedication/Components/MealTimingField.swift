//
//  MealTimingField.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 05/02/2026.
//

import Foundation
import SwiftUI

struct MealTimingField: View {
    @Binding var isBeforeMeal: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Par rapport au repas")
                .font(.custom("Inter", size: 16))
                .foregroundColor(.dimGrey)
                .padding(.horizontal)

            HStack(spacing: 0) {
                Button {
                    isBeforeMeal = true
                } label: {
                    Text("Avant")
                        .font(.custom("Inter", size: 16))
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(isBeforeMeal ? Color.icyBlue : Color.white)
                        .foregroundColor(isBeforeMeal ? .white : .black)
                        .fontWeight(.medium)
                }

                Divider()
                    .frame(width: 1)
                    .background(Color.gray.opacity(0.3))

                Button {
                    isBeforeMeal = false
                } label: {
                    Text("Après")
                        .font(.custom("Inter", size: 16))
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(!isBeforeMeal ? Color.icyBlue : Color.white)
                        .foregroundColor(!isBeforeMeal ? .white : .black)
                        .fontWeight(.medium)
                }
            }
            .clipShape(Capsule())
            .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
        }
        .padding()
    }
}
