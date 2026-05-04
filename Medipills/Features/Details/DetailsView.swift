//
//  DetailsView.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 12/03/2026.
//

import SwiftUI

struct DetailsView: View {
    let medication: MedicationItem
    
    @Environment(\.dismiss) var dismiss

    static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.locale = Locale(identifier: "fr_FR")
        return f
    }()

    // Back button computed property
    var backButton: some View {
        Button {
            dismiss()
        } label: {
            HStack(spacing: 4) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 14, weight: .semibold))
                Text("Retour")
                    .font(.custom("Poppins-Bold", size: 14))
            }
            .foregroundStyle(Color.icyBlue)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.white)
            .clipShape(Capsule())
            .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
        }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            if let formEnum = MedicationForm(rawValue: medication.form ?? "") {

                VStack(spacing: 0) {

                    MedicationHeaderView(
                        form: formEnum,
                        name: medication.name ?? "",
                        formLabel: medication.form ?? ""
                    )

                    MedicationInfoView(
                        medication: medication,
                        formEnum: formEnum
                    )

                    if !(medication.notes ?? "").isEmpty {
                        VStack(spacing: 0) {
                            SectionTitle(title: "Notes")
                            NotesView(notes: medication.notes ?? "")
                        }
                    }

                    Spacer().frame(height: 40)
                }
            }
        }
        .background(Color.aliceBlue.ignoresSafeArea())
        .navigationTitle("Détails")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        DetailsView(medication: MedicationItem(context: PersistenceController.shared.context))
    }
}
