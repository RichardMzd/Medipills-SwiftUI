//
//  DosageField.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 05/02/2026.
//

import Foundation
import SwiftUI

struct DosageField: View {
    let doseValueText: String
    let onMinus: () -> Void
    let onPlus: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Dosage")
                .font(.custom("Inter", size: 16))
                .foregroundColor(.dimGrey)
                .padding(.horizontal)

            HStack(spacing: 12) {
                Button(action: onMinus) {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.icyBlue)
                }

                Text(doseValueText)
                    .font(.custom("Inter", size: 16))
                    .frame(minWidth: 40)

                Button(action: onPlus) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.icyBlue)
                }
            }
            .padding(.horizontal)
            .frame(height: 56)
            .background(Color.white)
            .clipShape(Capsule())
            .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
        }
    }
}
