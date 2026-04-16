//
//  MedipillsApp.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 25/04/2025.
//

import SwiftUI
import UserNotifications


@main
struct MedipillsApp: App {
    
    init() {
        UserDefaults.standard.removeObject(forKey: "username")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
