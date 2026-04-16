//
//  DateCircleView.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 23/12/2025.
//

import SwiftUI

struct DateCircleView: View {
    let date: Date
    let selectedDate: Date?
    var onTap: (Date) -> Void

    private var isSelected: Bool {
        guard let selectedDate else { return false }
        return Calendar.current.isDate(selectedDate, inSameDayAs: date)
    }
    
    private var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }

    var body: some View {
        Button(action: {
            onTap(date)
        }) {
            VStack(spacing: 8) {
                // Jour de la semaine - TOUJOURS VISIBLE
                Text(HomePageView.dayFormatter.string(from: date).prefix(3).capitalized)
                    .font(.custom("Inter", size: 12))
                    .foregroundColor(.gray)  // Toujours gris
                
                // Numéro du jour
                Text(HomePageView.dateFormatter.string(from: date))
                    .font(.custom("Poppins-SemiBold", size: 18))
                    .foregroundColor(isSelected ? .white : .black)
                    .frame(width: 44, height: 44)
                    .background(
                        Circle()
                            .fill(isSelected ? Color.icyBlue : Color.clear)
                    )
                    .overlay(
                        Circle()
                            .stroke(
                                isToday && !isSelected ? Color.icyBlue.opacity(0.5) : Color.clear,
                                lineWidth: 2
                            )

                    )
                    .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)

            }

        }
        .buttonStyle(PlainButtonStyle())
    }
}
struct DateCircleView_Previews: PreviewProvider {
    static var previews: some View {
        // Exemple avec aujourd'hui sélectionné
        DateCircleView(date: Date(), selectedDate: Date()) { _ in
            // action simulée
        }
        .previewLayout(.sizeThatFits)
        .padding()
        
        // Exemple avec une autre date non sélectionnée
        DateCircleView(date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
                       selectedDate: Date()) { _ in }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

