//
//  GenericPicker.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 04/02/2026.
//

import Foundation
import SwiftUI

struct GenericPicker<T: PickerOption>: View {
    let title: String
    @Binding var selection: T

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.custom("Inter", size: 16))
                .foregroundColor(.dimGrey)
                .padding(.horizontal)

            Menu {
                ForEach(Array(T.allCases), id: \.id) { option in
                    Button {
                        selection = option
                    } label: {
                        HStack {
                            Text(option.textValue)
                                .foregroundStyle(.icyBlue)
                            if option == selection {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.icyBlue)
                            }
                        }
                    }
                }
            } label: {
                HStack {
                    Text(selection.textValue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.custom("Inter", size: 16))
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .lineLimit(1)          // ← empêche le retour à la ligne
                        .minimumScaleFactor(0.8) // ← réduit légèrement si nécessaire
                    Image(systemName: "chevron.up.chevron.down")
                        .foregroundColor(.icyBlue)
                }
                .padding(.horizontal)
                .frame(height: 56)
                .background(Color.white)
                .clipShape(Capsule())
                .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
            }
            .menuStyle(.automatic)
            .buttonStyle(PlainButtonStyle()) // ← ajoute ceci

        }
    }
}
