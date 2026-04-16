//
//  Medication.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 02/02/2026.
//

import Foundation

struct Medication: Identifiable {
    let id = UUID()
    let name: String
    let doseValue: Double
    let form: String
    let date: Date
    let moment: DayMoment 
    let isBeforeMeal: Bool
}
