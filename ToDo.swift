//
//  ToDo.swift
//  ToDoList
//
//  Created by Aimee Hong on 10/15/24.
//

import Foundation
import SwiftData

@Model
class ToDo {
    var item: String = ""
    var reminderIsOn = false
    var isCompleted = false
    var notes = ""
    var dueDate = Date.now + 60*60*24
    
    init(item: String = "", reminderIsOn: Bool = false, isCompleted: Bool = false, notes: String = "", dueDate: Date = Date.now + 60*60*24) {
        self.item = item
        self.reminderIsOn = reminderIsOn
        self.isCompleted = isCompleted
        self.notes = notes
        self.dueDate = dueDate
    }
}
