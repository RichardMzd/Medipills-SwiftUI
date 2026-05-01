//
//  MedicationListView.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 01/05/2026.
//

import SwiftUI

struct MedicationListView: View {
    @Binding var selectedDate: Date?
    @EnvironmentObject var medicationVM: MedicationViewModel
    @Binding var isLongPressing: Bool
    @Binding var navigationTarget: MedicationItem?
    @Binding var selectedMedication: MedicationItem?
    var onShowToast: (String) -> Void
    
    var body: some View {
        if let date = selectedDate {
            let meds = medicationVM.medications(for: date)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Médicaments du jour")
                    .font(.custom("Inter", size: 16))
                    .foregroundColor(.dimGrey)
                    .padding(.horizontal, 25)
                
                if meds.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.icyBlue.opacity(0.3))
                        
                        Text("Aucune prise prévue")
                            .font(.custom("Inter", size: 16))
                            .foregroundColor(.dimGrey)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 40)
                } else {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(DayMoment.allCases, id: \.self) { moment in
                            let meds = medicationVM.medicationsByMoment(for: date, moment: moment)
                            
                            if !meds.isEmpty {
                                Text(moment.rawValue)
                                    .font(.custom("Poppins-Bold", size: 16))
                                    .padding(.horizontal, 25)
                                
                                HStack(alignment: .top, spacing: 12) {
                                    Rectangle()
                                        .frame(width: 1.5)
                                        .cornerRadius(2)
                                        .foregroundColor(.icyBlue)
                                    
                                    VStack(alignment: .leading, spacing: 10) {
                                        ForEach(meds) { med in
                                            if let formEnum = MedicationForm(rawValue: med.form ?? "") {
                                                let doseText = formEnum.finalDoseText(value: med.doseValue)
                                                let beforeOrAfter = formEnum.beforeOfAfterMeal(value: med.isBeforeMeal)
                                                
                                                ZStack(alignment: .trailing) {
                                                    Button {
                                                        if !isLongPressing {
                                                            navigationTarget = med
                                                        }
                                                        isLongPressing = false
                                                    } label: {
                                                        MedicationView(
                                                            name: med.name ?? "",
                                                            doseValue: med.doseValue,
                                                            form: formEnum,
                                                            doseText: doseText,
                                                            moment: DayMoment(rawValue: med.moment ?? "") ?? .morning,
                                                            isBeforeMeal: beforeOrAfter,
                                                            startDate: med.startDate ?? Date(),
                                                            currentDate: Date(),
                                                            frequency: FrequencyForm(rawValue: med.frequency ?? "") ?? .everyDay,
                                                            isTaken: medicationVM.isTaken(med, on: date)
                                                        )
                                                    }
                                                    .buttonStyle(.plain)
                                                    .swipeActions(edge: .trailing) {
                                                        Button(role: .destructive) {
                                                            medicationVM.delete(med)
                                                        } label: {
                                                            Label("Delete", systemImage: "trash")
                                                        }
                                                    }
                                                    .lineLimit(1)
                                                    .onLongPressGesture(minimumDuration: 0.4) {
                                                        selectedMedication = med
                                                    }
                                                    
                                                    // ✅ Bouton checkmark avec vérification date future
                                                    Button {
                                                        let today = Calendar.current.startOfDay(for: Date())
                                                        let selected = Calendar.current.startOfDay(for: date)
                                                        
                                                        if selected > today {
                                                            onShowToast(
                                                                "Impossible de valider une prise future"
                                                            )
                                                        } else {
                                                            medicationVM.toggleTaken(med, on: date)
                                                        }
                                                    } label: {
                                                        Image(systemName: medicationVM.isTaken(med, on: date) ? "checkmark.circle.fill" : "circle")
                                                            .font(.system(size: 24))
                                                            .foregroundColor(medicationVM.isTaken(med, on: date) ? .icyBlue : .gray.opacity(0.4))
                                                    }
                                                    .buttonStyle(.plain)
                                                    .padding(.trailing, 18)
                                                }
                                                .simultaneousGesture(
                                                    LongPressGesture(minimumDuration: 0.4).onEnded { _ in
                                                        isLongPressing = true
                                                        selectedMedication = med
                                                    }
                                                )
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal, 25)
                            }
                        }
                    }
                }
            }
        }    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let vm = MedicationViewModel(context: context)
    
    MedicationListView(
        selectedDate: .constant(Calendar.current.startOfDay(for: Date())),
        isLongPressing: .constant(false),
        navigationTarget: .constant(nil),
        selectedMedication: .constant(nil),
        onShowToast: { _ in }
    )
    .environmentObject(vm)
    .environment(\.managedObjectContext, context)
}
