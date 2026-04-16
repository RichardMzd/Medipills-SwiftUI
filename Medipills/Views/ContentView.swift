//
//  ContentView.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 25/04/2025.
//

import SwiftUI

struct ContentView: View {
    // écris ton @AppStorage ici
    @AppStorage("username") var username: String = ""
    
    var body: some View {
        // on remplira après
        if username.isEmpty {
            ProfilView()
        } else {
            MainTabView()
        }
    }
}

#Preview {
    ContentView()
}




