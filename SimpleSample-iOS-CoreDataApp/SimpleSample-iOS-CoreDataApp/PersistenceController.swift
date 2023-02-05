//
//  PersistenceController.swift
//  SimpleSample-iOS-CoreDataApp
//
//  Created by Jo JANGHUI on 2023/01/28.
//

import CoreData


struct PersistenceController {
    static let shared = PersistenceController(modelDataNama: "")
    
    static var preview: PersistenceController = {
        let result = PersistenceController(modelDataNama: "", inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Entity(context: viewContext)
            newItem.img = Data()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            let nsError = error as NSError
            debugPrint("🔴🔴🔴 Unresolved error \(nsError)")
        }
        return result
    }()
    
    
    let container: NSPersistentContainer
    
    init(modelDataNama: String, inMemory: Bool = false) {
        container = NSPersistentContainer(name: modelDataNama)
        
        if (inMemory) {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            guard let error = error as NSError? else { return }
            /*
             Typical reasons for an error here include:
             * The parent directory does not exist, cannot be created, or disallows writing.
             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
             * The device is out of space.
             * The store could not be migrated to the current model version.
             Check the error message to determine what the actual problem was.
             */
            debugPrint("🔴🔴🔴 Unresolved error \(error), \(error.userInfo)")
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
