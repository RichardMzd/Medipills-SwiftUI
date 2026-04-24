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

    var body: some View {
        ScrollView(showsIndicators: false) {
            if let formEnum = MedicationForm(rawValue: medication.form ?? "") {
                let doseText = formEnum.finalDoseText(value: medication.doseValue)

                VStack(spacing: 0) {

                    VStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 65, height: 65)
                            Image(formEnum.iconName)
                                .font(.system(size: 32))
                                .foregroundStyle(Color.icyBlue)
                        }
                        .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)

                        Text(medication.name ?? "")
                            .font(.custom("Poppins-Bold", size: 22))
                            .multilineTextAlignment(.center)

                        // Badge forme
                        Text(medication.form ?? "")
                            .font(.custom("Poppins-Bold", size: 12))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 5)
                            .background(Color.icyBlue)
                            //.clipShape(Capsule())
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 28)
                    .padding(.horizontal, 20)
                    //.background(Color.aliceBlue.opacity(0.5))

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
                                value: DetailsView.dateFormatter
                                    .string(
                                        from: medication.startDate ?? Date()
                                    )
                            )
                        }
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        //.shadow(color: .black.opacity(0.05), radius: 8, y: 4)
                        .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
                        .padding(.horizontal, 20)
                    }

                    // ── NOTES ─────────────────────────────────────────
                    if !(medication.notes ?? "").isEmpty {
                        VStack(spacing: 0) {
                            SectionTitle(title: "Notes")

                            HStack(alignment: .top, spacing: 12) {
                                Image(systemName: "note.text")
                                    .font(.system(size: 15))

                                    .padding(9)
                                    .background(Color.aliceBlue)
                                    .clipShape(RoundedRectangle(cornerRadius: 9))

                                Text(medication.notes ?? "")
                                    .font(.custom("Inter", size: 14))
                                    .foregroundStyle(.dimGrey)
                                    .fixedSize(horizontal: false, vertical: true)

                                Spacer()
                            }
                            .padding(16)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                           // .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
                            .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
                            .padding(.horizontal, 20)
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
        }
    }
}

// MARK: - Section Title

private struct SectionTitle: View {
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

// MARK: - Preview

#Preview {
    NavigationStack {
        DetailsView(medication: MedicationItem(context: PersistenceController.shared.context))
    }
}
