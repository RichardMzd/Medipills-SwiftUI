//
//  AddMedicationView.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 28/12/2025.
//

import SwiftUI

struct AddMedicationView: View {

    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm : AddMedicationViewModel
    var medicationToEdit: MedicationItem? = nil
    
    init(
        medicationToEdit: MedicationItem? = nil,
        addMedicationAction: @escaping (
            _ name: String,
            _ doseValue: Double,
            _ form: String,
            _ startDate: Date,
            _ moment: DayMoment,
            _ isBeforeMeal: Bool,
            _ frequency: FrequencyForm,
            _ notes: String,
            _ reminderEnabled: Bool,
            _ reminderTime: Date
        ) -> Void
    ) {
        _vm = StateObject(wrappedValue: AddMedicationViewModel(medication: medicationToEdit))
        self.addMedicationAction = addMedicationAction
    }

    var addMedicationAction: (
        _ name: String,
        _ doseValue: Double,
        _ form: String,
        _ startDate: Date,
        _ moment: DayMoment,
        _ isBeforeMeal: Bool,
        _ frequency: FrequencyForm,
        _ notes: String,
        _ reminderEnabled: Bool,
        _ reminderTime: Date
    ) -> Void

    var body: some View {
        VStack {
            Spacer()

            VStack {
                Capsule()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 40, height: 5)
                    .padding(.top, 8)

                Text("Ajouter un médicament")
                    .font(.custom("Poppins-Bold", size: 20))
                    .padding(.vertical, 20)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 10) {

                        LabeledCapsuleTextField(
                            title: "Nom du médicament",
                            placeholder: "Ex : Doliprane",
                            text: $vm.name
                        )

                        HStack(alignment: .top, spacing: 12) {
                            DosageField(
                                doseValueText: vm.doseValue.clean,
                                onMinus: vm.decrementStep,
                                onPlus: vm.incrementStep
                            )
                            GenericPicker(
                                title: "Forme",
                                selection: $vm.selectedForm
                            )
                        }
                        .padding()

                        MomentField(selectedMoment: $vm.selectedMoment)
                        MealTimingField(isBeforeMeal: $vm.isBeforeMeal)

                        HStack(alignment: .top, spacing: 12) {
                            GenericPicker(
                                title: "Fréquence",
                                selection: $vm.selectedFrequency
                            )
                            DateSelector(startDate: $vm.startDate)
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Toggle("Rappel", isOn: $vm.reminderEnabled)
                                .font(.custom("Inter", size: 16))
                                .foregroundColor(.dimGrey)
                                .padding(.horizontal, 16)
                                .tint(.icyBlue)
                            
                            if vm.reminderEnabled {
                                DatePicker(
                                    "Heure du rappel",
                                    selection: $vm.reminderTime,
                                    displayedComponents: .hourAndMinute
                                )
                                .font(.custom("Inter", size: 16))
                                .foregroundColor(.dimGrey)
                                .padding(.horizontal, 16)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8)

                        VStack(alignment: .leading, spacing: 12) {
                            Text("Notes (Optionnel)")
                                .font(.custom("Inter", size: 16))
                                .foregroundColor(.dimGrey)
                                .padding(.leading, 16)
                            NotesField(notes: $vm.notes)
                        }
                        .padding(.horizontal)
                        .padding(.top, 16)
                        .padding(.bottom, 10)
                        

                    }
                }
                .padding()

                // MARK: - Submit button
                Button {
                    guard vm.validate() else { return }
                    addMedicationAction(
                        vm.name,
                        vm.doseValue,
                        vm.selectedForm.rawValue,
                        vm.startDate,
                        vm.selectedMoment,
                        vm.isBeforeMeal,
                        vm.selectedFrequency,
                        vm.notes,
                        vm.reminderEnabled,
                        vm.reminderTime
                    )
                    dismiss()
                } label: {
                    Text("Ajouter")
                        .font(.custom("Poppins-Bold", size: 16))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.icyBlue)
                        .clipShape(Capsule())
                }
                .padding(20)
                .alert("Erreur", isPresented: .constant(vm.currentError != nil)) {
                    Button("OK", role: .cancel) { vm.currentError = nil }
                } message: {
                    switch vm.currentError {
                    case .emptyName: Text("Veuillez entrer le nom du médicament")
                    case .emptyDosage: Text("Veuillez ajouter un dosage")
                    case .none: EmptyView()
                    }
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 30)
            .frame(maxWidth: .infinity)
            .background(
                RoundedCorner(radius: 45, corners: [.topLeft, .topRight])
                    .fill(Color.aliceBlue)
            )
            .shadow(color: .gray.opacity(0.3), radius: 8, x: 0, y: -3)
        }
        .background(Color.aliceBlue)
    }
}



// MARK: - Preview
struct AddMedicationView_Previews: PreviewProvider {
    static var previews: some View {
        AddMedicationView { name, doseValue, form, date, moment, isBeforeMeal, frequency, notes, reminderEnabled, reminderTime in
            print("""
            Médicament ajouté :
            - Nom : \(name)
            - Dosage : \(doseValue)
            - Forme : \(form)
            - Date : \(date)
            - Moment : \(moment.rawValue)
            - Avant repas : \(isBeforeMeal ? "Oui" : "Non")
            """)
        }
    }
}
