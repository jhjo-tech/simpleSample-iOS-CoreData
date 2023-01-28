//
//  SimpleSample_iOS_CoreDataAppApp.swift
//  SimpleSample-iOS-CoreDataApp
//
//  Created by Jo JANGHUI on 2023/01/28.
//

import SwiftUI

@main
struct SimpleSample_iOS_CoreDataAppApp: App {
    var persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
