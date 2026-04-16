//
//  MedicationForm.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 29/12/2025.
//

import Foundation
import SwiftUI

enum MedicationForm: String, PickerOption, CaseIterable {
    case comprime = "Comprimé"
    case gelule = "Gélule"
    case sirop = "Sirop"
    
    
    var id: String { rawValue }
    var textValue: String { rawValue }
    var iconName: String {
        switch self {
        case .comprime:
            return "tablet-64"
            
        case .gelule:
            return "capsule-64"
            
        case .sirop:
            return "bottle-64"
        }
    }
    
    
    // Texte final utilisé après validation ("Ajouter")
    func finalDoseText(value: Double) -> String {
        let cleanValue = value.clean
        
        switch self {
        case .comprime:
            return "\(cleanValue) comprimé\(value > 1 ? "s" : "")"
            
        case .gelule:
            return "\(cleanValue) gélule\(value > 1 ? "s" : "")"
            
        case .sirop:
            return "\(cleanValue) c. à s. 🥄"
        }
    }
    
    func beforeOfAfterMeal(value: Bool) -> String {
        return "\(value ? "Avant repas" : "Après repas")"
    }
}


enum DoseUnit: String {
    
    func label(for value: Double) -> String {
        value > 1 ? "\(rawValue)s" : rawValue
    }
    case comprime = "comprimé"
    case gelule = "gélule"
    case ml = "ml"
}

