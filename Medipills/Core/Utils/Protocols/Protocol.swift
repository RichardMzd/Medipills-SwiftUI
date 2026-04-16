//
//  Protocol.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 04/02/2026.
//

import Foundation
import SwiftUI

protocol PickerOption: Identifiable, CaseIterable, Equatable {
    var textValue: String { get }
}
