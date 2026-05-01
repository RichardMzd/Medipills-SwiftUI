//
//  HorizontalDateView.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 01/05/2026.
//

import SwiftUI

struct HorizontalDateView: View {
    
    let dateArray: [Date]
    @Binding var selectedDate: Date?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(dateArray, id: \.self) { date in
                    DateCircleView(
                        date: date,
                        selectedDate: selectedDate
                    ) { newDate in
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedDate = Calendar.current.startOfDay(for: newDate)
                        }
                    }
                }
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 16)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 30))
        .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
        .padding(.horizontal, 25)
    }
}

#Preview {
    HorizontalDateView(
        dateArray: (0...6).compactMap {
            Calendar.current.date(byAdding: .day, value: $0, to: Calendar.current.startOfDay(for: Date()))
        },
        selectedDate: .constant(Calendar.current.startOfDay(for: Date()))
    )
}
