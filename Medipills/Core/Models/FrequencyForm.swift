//
//  FrequencyForm.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 04/02/2026.
//

import Foundation
import SwiftUI

enum FrequencyForm: String, PickerOption, CaseIterable {
    
    case everyDay = "Tous les jours"
    case threeDay = "3 jours"
    case oneWeek = "Une semaine"
    
    var id: String { rawValue }
    var textValue: String { rawValue }

}
