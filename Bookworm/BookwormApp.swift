//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Kimberly Brewer on 8/8/23.
//

import SwiftUI

@main
struct BookwormApp: App {
    // Make it once and then we'll use environment so everywhere in our app can use it
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
            // managedObjectContext - live version of your data
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
