//
//  MedicationInfoView.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 04/05/2026.
//

import SwiftUI

struct MedicationInfoView: View {
    
    let medication: MedicationItem
    let formEnum: MedicationForm
    
    static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.locale = Locale(identifier: "fr_FR")
        return f
    }()
    
    var body: some View {
        let doseText = formEnum.finalDoseText(value: medication.doseValue)
        // ── INFOS ─────────────────────────────────────────
        VStack(spacing: 0) {
            SectionTitle(title: "Informations")
            
            VStack(spacing: 1) {
                DetailsRow(icon: "pills.fill", label: "Dosage", value: doseText)
                DetailsRow(icon: "clock.fill", label: "Moment", value: medication.moment ?? "")
                DetailsRow(icon: "fork.knife", label: "Repas", value: formEnum.beforeOfAfterMeal(value: medication.isBeforeMeal))
                DetailsRow(icon: "repeat", label: "Fréquence", value: medication.frequency ?? "")
                DetailsRow(
                    icon: "calendar",
                    label: "Date de début",
                    value: MedicationInfoView.dateFormatter
                        .string(
                            from: medication.startDate ?? Date()
                        )
                )
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    MedicationInfoView(
        medication: MedicationItem(context: PersistenceController.preview.container.viewContext),
        formEnum: .gelule
    )
}
