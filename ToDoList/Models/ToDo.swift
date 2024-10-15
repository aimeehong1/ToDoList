//
//  ToDo.swift
//  ToDoList
//
//  Created by Aimee Hong on 10/15/24.
//

import Foundation
import SwiftData

@MainActor
@Model
class ToDo {
    var item: String = ""
    var reminderIsOn = false
    var dueDate = Date.now + 60*60*24
    var notes = ""
    var isCompleted = false
    var timeStamp = Date.now
    
    init(item: String = "", reminderIsOn: Bool = false, dueDate: Date = Date.now + 60*60*24, notes: String = "", isCompleted: Bool = false, timeStamp: Date = Date.now) {
        self.item = item
        self.reminderIsOn = reminderIsOn
        self.dueDate = dueDate
        self.notes = notes
        self.isCompleted = isCompleted
        self.timeStamp = timeStamp
    }
}

extension ToDo {
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: ToDo.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        container.mainContext.insert(ToDo(item: "Watch Swift Data Lessons", reminderIsOn: true, dueDate: Date.now + 60*60*24, notes: "Now with iOS 16 and XCode 18", isCompleted: false))
        container.mainContext.insert(ToDo(item: "Write Economics of Inequality Paper", reminderIsOn: true, dueDate: Date.now + 60*60*24, notes: "Need to utilize STATA!", isCompleted: false))
        container.mainContext.insert(ToDo(item: "Prepare for Computer Organization midterm", reminderIsOn: true, dueDate: Date.now + 60*60*48, notes: "Everything up to sequential logic", isCompleted: false))
        container.mainContext.insert(ToDo(item: "Prepare for Randomness and Computation midterm", reminderIsOn: true, dueDate: Date.now + 60*60*72, notes: "Focus on distributions and combinations & permutations", isCompleted: false))
        
        return container
    }
}
