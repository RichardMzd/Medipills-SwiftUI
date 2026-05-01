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
    
    // ✅ Ajoute ça
    static let preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        return controller
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Medipills")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
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
