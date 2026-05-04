//
//  NotesView.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 04/05/2026.
//

import SwiftUI

struct NotesView: View {
    let notes: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "note.text")
                .font(.system(size: 15))
            
                .padding(9)
                .background(Color.aliceBlue)
                .clipShape(RoundedRectangle(cornerRadius: 9))
            
            Text(notes)
                .font(.custom("Inter", size: 14))
                .foregroundStyle(.dimGrey)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
        .padding(.horizontal, 20)
    }
}

#Preview {
    NotesView(notes: "Prendre avec de l'eau")
}
