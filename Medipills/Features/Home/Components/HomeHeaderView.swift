//
//  HomeHeaderView.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 01/05/2026.
//

import SwiftUI

struct HomeHeaderView: View {
    
    @AppStorage("username") var username: String = ""
    let selectedDate: Date?
    
    static let fullDateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "fr_FR")
        f.setLocalizedDateFormatFromTemplate("EEEE d MMMM")
        return f
    }()
    
    var isTodaySelected: Bool {
        guard let selectedDate else { return false }
        return Calendar.current.isDateInToday(selectedDate)
    }
    
    var time: String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour < 5 {
            return "Bonne nuit"
        } else if hour >= 17 {
            return "Bonsoir"
        } else {
            return "Bonjour"
        }
    }

    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 5) {
                Text(time)
                    .font(.custom("Poppins-Bold", size: 24))
                    .foregroundColor(.black)
                Text(username)
                    .font(.custom("Inter", size: 24))
                    .foregroundColor(.black)
            }
            
            Text(isTodaySelected ? "Aujourd'hui" : HomeHeaderView.fullDateFormatter
                .string(from: selectedDate ?? Date())
                .capitalized
            )
            .font(.custom("Inter", size: 16))
            .foregroundColor(.dimGrey)
        }
        .padding(.horizontal, 25)
        .padding(.top, 20)
    }
}

#Preview {
    HomeHeaderView(
        selectedDate: Calendar.current.startOfDay(for: Date())
    )
}
