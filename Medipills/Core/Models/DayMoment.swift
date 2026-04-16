//
//  DayMoment.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 30/01/2026.
//

import Foundation

enum DayMoment: String, CaseIterable, Identifiable {
    case morning = "Matin"
    case noon = "Midi"
    case evening = "Soir"
    
    var id: String { self.rawValue }
    
    // Pour trier les médicaments par moment de la journée
    var sortOrder: Int {
        switch self {
        case .morning: return 0
        case .noon: return 1
        case .evening: return 2
        }
    }
}
