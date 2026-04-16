//
//  BottomToolBar.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 23/12/2025.
//

import SwiftUI

struct BottomToolbar: View {
    let selectedDate: Date?
    let medications: (Date) -> [(name: String, type: String)]
    
    var body: some View {
        HStack {
            // Home
            Button(action: { print("Home tapped") }) {
                Image(systemName: "house.fill")
                    .font(.title2)
                    .foregroundColor(.blueMed)
            }
            
            Spacer()
            
            // Bouton + central
            Button(action: { print("Add tapped") }) {
                Image(systemName: "plus")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(
                        (selectedDate != nil && !medications(selectedDate!).isEmpty)
                        ? Color.greenMed
                        : Color.blueMed
                    )
                    .clipShape(Circle())
                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
            }
            
            Spacer()
            
            // Profile
            Button(action: { print("Profile tapped") }) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.title2)
                    .foregroundColor(.blueMed)
            }
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.grayMed.opacity(0.2))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.greenMed.opacity(0.5), lineWidth: 2)
                )
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
        )
        .padding(.horizontal, 16)
    }
}




struct BottomToolbar_Previews: PreviewProvider {
    static var previews: some View {
        BottomToolbar(selectedDate: Date()) { _ in
            [("Doliprane", "D")] // Exemple meds pour preview
        }
        .previewLayout(.sizeThatFits)
    }
}

