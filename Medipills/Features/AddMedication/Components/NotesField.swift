//
//  NotesField.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 05/02/2026.
//

import Foundation
import SwiftUI

struct NotesField: View {
    @Binding var notes: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Placeholder
            if notes.isEmpty {
                Text("Ex: prendre avec de l'eau")
                    .foregroundColor(.gray.opacity(0.5))
                    .padding(.horizontal, 12)
                    .padding(.top, 12)
            }

            TextEditor(text: $notes)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .scrollContentBackground(.hidden)
        }
        .frame(height: 120) // ← hauteur du carré
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
    }
}
