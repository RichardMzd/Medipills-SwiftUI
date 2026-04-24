//
//  PersistenceController.swift
//  Medipills
//
//  Created by Richard Arif Mazid on 24/04/2026.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Medipills")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Erreur Core Data : \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
}

