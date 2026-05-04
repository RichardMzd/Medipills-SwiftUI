//
//  SectionTitle.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 04/05/2026.
//

import SwiftUI

struct SectionTitle: View {
    let title: String
    var body: some View {
        HStack {
            Text(title.uppercased())
                .font(.custom("Poppins-SemiBold", size: 11))
                .foregroundStyle(.dimGrey)
                .tracking(0.8)
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 24)
        .padding(.bottom, 10)
    }
}

