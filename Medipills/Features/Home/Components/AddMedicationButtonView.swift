//
//  AddMedicationButtonView.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 01/05/2026.
//

import SwiftUI

struct AddMedicationButtonView: View {
    
    @State private var showAddMedicationSheet = false
    @EnvironmentObject var medicationVM: MedicationViewModel

    var body: some View {
        Button(action: {
            showAddMedicationSheet = true
        }) {
            Image(systemName: "plus")
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(
                    LinearGradient(
                        colors: [Color.icyBlue, Color.icyBlue.opacity(0.8)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(Circle())
                .shadow(color: .gray.opacity(0.8), radius: 5, x: 0, y: 5)
        }
        .padding(.trailing, 24)
        .padding(.bottom, 24)
        .sheet(isPresented: $showAddMedicationSheet) {
            AddMedicationView { name, doseValue, form, date, moment, isBeforeMeal, frequency, notes, reminderEnabled, reminderTime in
                medicationVM.addMedication(
                    name: name,
                    doseValue: doseValue,
                    form: form,
                    date: date,
                    moment: moment,
                    isBeforeMeal: isBeforeMeal,
                    frequency: frequency,
                    notes: notes,
                    reminderEnabled: reminderEnabled,
                    reminderTime: reminderTime
                )
            }
            .presentationDetents([.large])
            .presentationBackground(.clear)
            .presentationCornerRadius(45)
            .presentationDragIndicator(.hidden)
            .presentationBackground(Color.aliceBlue)
        }    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let vm = MedicationViewModel(context: context)
    
    AddMedicationButtonView()
        .environmentObject(vm)
        .environment(\.managedObjectContext, context)
}
