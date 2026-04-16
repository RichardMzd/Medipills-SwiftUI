//
//  CustomButtons.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 02/05/2025.
//
import SwiftUI

struct CustomButtons {
    
    var body: some View {
        Button("Se connecter", action: {
            print("Button tapped!")
        })
        .foregroundStyle(.blueMed)
        .buttonBorderShape(.roundedRectangle(radius: 25))
    }
    
    
}
