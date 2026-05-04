//
//  MedicationHeaderView.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 04/05/2026.
//

import SwiftUI

struct MedicationHeaderView: View {
    
    let form: MedicationForm
    let name: String
    let formLabel: String
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 65, height: 65)
                Image(form.iconName)
                    .font(.system(size: 32))
                    .foregroundStyle(Color.icyBlue)
            }
            .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
            
            Text(name)
                .font(.custom("Poppins-Bold", size: 22))
                .multilineTextAlignment(.center)
            
            // Badge forme
            Text(formLabel)
                .font(.custom("Poppins-Bold", size: 12))
                .foregroundStyle(.white)
                .padding(.horizontal, 14)
                .padding(.vertical, 5)
                .background(Color.icyBlue)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 28)
        .padding(.horizontal, 20)
    }
}

#Preview {
    MedicationHeaderView(
        form: MedicationForm.gelule,
        name: "Advil",
        formLabel: "Gélule"
    )
}
