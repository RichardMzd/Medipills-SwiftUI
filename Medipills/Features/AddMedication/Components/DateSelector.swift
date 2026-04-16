//
//  DateSelector.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 05/02/2026.
//

import Foundation
import SwiftUI

struct DateSelector: View {
    @Binding var startDate: Date
    @State private var showPicker = false

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: startDate)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Date de début")
                .font(.custom("Inter", size: 16))
                .foregroundColor(.dimGrey)
                .padding(.horizontal)

            Button {
                showPicker.toggle()
            } label: {
                HStack {
                    Spacer()
                    Text(formattedDate)
                        .font(.custom("Inter", size: 16))
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                    Spacer()
                }
                .padding(.horizontal)
                .frame(height: 56)
                .background(Color.white)
                .clipShape(Capsule())
                .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
            }
            .sheet(isPresented: $showPicker) {
                VStack {
                    DatePicker(
                        "",
                        selection: $startDate,
                        displayedComponents: .date
                    )
                    .labelsHidden()
                    .datePickerStyle(.graphical)
                    .environment(\.locale, Locale(identifier: "fr_FR"))
                    .padding()

                    Button("Confirmer") {
                        showPicker = false
                    }
                    .font(.custom("Poppins-Bold", size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.icyBlue)
                    .clipShape(Capsule())
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
                .presentationDetents([.medium])
            }
        }
    }
}
