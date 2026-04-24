//
//  MedipillsApp.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 25/04/2025.
//

import SwiftUI
import UserNotifications
import CoreData

@main
struct MedipillsApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.context)
        }
    }
}
