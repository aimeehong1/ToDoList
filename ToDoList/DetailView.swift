//
//  DetailView.swift
//  ToDoList
//
//  Created by Aimee Hong on 10/13/24.
//

import SwiftUI

struct DetailView: View {
    @State var toDo: String
    @State private var reminderIsOn = false
    @State private var isCompleted = false
    @State private var notes = ""
    @State private var dueDate = Calendar.current.date(byAdding: .day, value: 1, to: Date.now)!
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        List {
            TextField("Enter To Do here", text: $toDo)
                .font(.title)
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
                .listRowSeparator(.hidden)
            
            Toggle("Set Reminder", isOn: $reminderIsOn)
                .padding(.top)
                .listRowSeparator(.hidden)
            
            DatePicker("Date", selection: $dueDate)
                .listRowSeparator(.hidden)
                .disabled(!reminderIsOn)
            
            Text("Notes:")
                .padding(.top)
            
            TextField("Notes", text: $notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .listRowSeparator(.hidden)
            
            Toggle("Completed", isOn: $isCompleted)
                .padding(.top)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                // TODO: add save code here
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(toDo: "")
    }
}
