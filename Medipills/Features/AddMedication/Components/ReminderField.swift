//
//  ReminderField.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 04/05/2026.
//

import SwiftUI

struct ReminderField: View {
    @Binding var reminderEnabled: Bool
    @Binding var reminderTime: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Toggle("Rappel", isOn: $reminderEnabled)
                .font(.custom("Inter", size: 16))
                .foregroundColor(.dimGrey)
                .padding(.horizontal, 16)
                .tint(.icyBlue)
            
            if reminderEnabled {
                DatePicker(
                    "Heure du rappel",
                    selection: $reminderTime,
                    displayedComponents: .hourAndMinute
                )
                .font(.custom("Inter", size: 16))
                .foregroundColor(.dimGrey)
                .padding(.horizontal, 16)
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

#Preview {
    ReminderField(
        reminderEnabled: .constant(true),
        reminderTime: .constant(Date())
    )
}
