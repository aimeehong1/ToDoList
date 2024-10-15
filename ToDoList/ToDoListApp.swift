//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Aimee Hong on 10/13/24.
//

import SwiftUI
import SwiftData

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            ToDoListView()
                .modelContainer(for: ToDo.self)
        }
    }
    
    // Will allow us to find where our simulator data is saved:
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
//        purgeData()
    }
    
    func purgeData() {
        let path = URL.documentsDirectory.appending(components: "toDos")
        let data = try? JSONEncoder().encode("")
        do {
            try data?.write(to: path)
        } catch {
            print("😡 ERROR: Could not save data \(error.localizedDescription)")
        }
    }
}
