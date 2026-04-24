//
//  AddMedicationViewModel.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 05/02/2026.
//

import Foundation
import SwiftUI

@MainActor
final class AddMedicationViewModel: ObservableObject {
    // Champs
    @Published var name: String = ""
    @Published var startDate: Date = Date()
    @Published var selectedForm: MedicationForm = .comprime
    @Published var selectedFrequency: FrequencyForm = .everyDay
    @Published var doseValue: Double = 0
    @Published var selectedMoment: DayMoment = .morning
    @Published var isBeforeMeal: Bool = true
    @Published var notes: String = ""
    @Published var reminderEnabled: Bool = true
    @Published var reminderTime: Date = Date()

    // UI / erreurs
    @Published var currentError: AddMedicationError?
    @Published var isExpanded: Bool = false
    
    init(medication: MedicationItem? = nil) {
        if let med = medication {
            self.name = med.name ?? ""
            self.doseValue = med.doseValue
            self.selectedForm = MedicationForm(rawValue: med.form ?? "") ?? .comprime
            self.selectedMoment = DayMoment(rawValue: med.moment ?? "") ?? .morning
            self.isBeforeMeal = med.isBeforeMeal
            self.selectedFrequency = FrequencyForm(rawValue: med.frequency ?? "") ?? .everyDay
            self.startDate = med.startDate ?? Date()
        }
    }

    // Logique dosage
    func stepValue() -> Double {
        switch selectedForm {
        case .comprime, .gelule: return 1
        case .sirop: return 0.5
        }
    }

    func incrementStep() {
        doseValue += stepValue()
        if doseValue > 10 { doseValue = 10 }
    }

    func decrementStep() {
        doseValue -= stepValue()
        if doseValue < 0 { doseValue = 0 }
    }

    // Validation
    func validate() -> Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            currentError = .emptyName
            return false
        }
        if doseValue <= 0 {
            currentError = .emptyDosage
            return false
        }
        return true
    }
}

