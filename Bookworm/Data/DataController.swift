//
//  DataController.swift
//  Bookworm
//
//  Created by Kimberly Brewer on 8/8/23.
//
import CoreData
import Foundation

class DataController: ObservableObject {
    // core data type responsible for loading a model and giving us access
    // to the data inside - the name refers to the data model we created
    // it PREPARES to load it
    let container = NSPersistentContainer(name: "Bookworm")
    // here's where we are going to load the data
    init() {
        // load persistent stores when our controller is created
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
