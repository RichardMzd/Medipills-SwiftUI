//
//  Double+Clean.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 05/02/2026.
//

import Foundation

extension Double {
    var clean: String {
        truncatingRemainder(dividingBy: 1) == 0
        ? String(Int(self))
        : String(self)
    }
}
