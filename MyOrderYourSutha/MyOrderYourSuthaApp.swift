//
//  MyOrderYourSuthaApp.swift
//  MyOrderYourSutha
//
//  Created by Suthakaran Siva on 2024-10-10.
//

import SwiftUI

@main
struct MyOrderYourSuthaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
