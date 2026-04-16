//
//  DetailsRow.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 12/03/2026.
//

import Foundation
import SwiftUI

struct DetailsRow: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .foregroundStyle(.icyBlue)
            Text(label)
                .font(.custom("Inter", size: 16))
                .foregroundStyle(.dimGrey)
            Spacer()
            Text(value)
                .font(.custom("Inter", size: 16))
        }
        .padding()
    }
    
}

#Preview {
    DetailsRow(
        icon: "pills.fill",
        label: "Doliprane",
        value: "Matin")
}
