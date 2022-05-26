//
//  CardsApp.swift
//  Cards
//
//  Created by Felipe Camara on 16/10/21.
//

import SwiftUI

@main
struct CardsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

struct CardsApp_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
