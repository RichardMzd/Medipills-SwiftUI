//
//  File.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 05/02/2026.
//

import Foundation
import SwiftUI

struct MomentField: View {
    @Binding var selectedMoment: DayMoment

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Quand ?")
                .font(.custom("Inter", size: 16))
                .foregroundColor(.dimGrey)
                .padding(.horizontal)

            HStack(spacing: 0) {
                ForEach(Array(DayMoment.allCases.enumerated()), id: \.element) { index, moment in
                    Button {
                        selectedMoment = moment
                    } label: {
                        Text(moment.rawValue)
                            .font(.custom("Inter", size: 16))
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(selectedMoment == moment ? Color.icyBlue : Color.white)
                            .foregroundColor(selectedMoment == moment ? .white : .black)
                            .fontWeight(.medium)
                    }

                    if index < DayMoment.allCases.count - 1 {
                        Divider()
                            .frame(width: 1)
                            .background(Color.gray.opacity(0.3))
                    }
                }
            }
            .clipShape(Capsule())
            .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
        }
        .padding()
    }
}
