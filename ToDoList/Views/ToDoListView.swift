//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Aimee Hong on 10/13/24.
//

import SwiftUI
import SwiftData

enum SortOption: String, CaseIterable {
    case asEntered = "As Entered"
    case alphabetical = "A-Z"
    case chronological = "Date"
    case completed = "Not Done"
}

struct SortedToDoList: View {
    @Query var toDos: [ToDo]
    @Environment(\.modelContext) var modelContext
    let sortSelection: SortOption
    
    init(sortSelection: SortOption) {
        self.sortSelection = sortSelection
        switch self.sortSelection {
        case .asEntered:
            _toDos = Query(sort: \.timeStamp)
        case .alphabetical:
            _toDos = Query(sort: \.item)
        case .chronological:
            _toDos = Query(sort: \.dueDate)
        case .completed:
            _toDos = Query(filter: #Predicate {$0.isCompleted == false})
        }
    }
    
    var body: some View {
        List {
            ForEach(toDos) { toDo in
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: toDo.isCompleted ? "checkmark.circle" : "circle")
                            .onTapGesture {
                                toDo.isCompleted.toggle()
                                guard let _ = try? modelContext.save() else {
                                    print("😡 ERROR: Save after .delete on ToDoListView did not work.")
                                    return
                                }
                            }
                        
                        NavigationLink {
                            DetailView(toDo: toDo)
                        } label: {
                            Text(toDo.item)
                        }
                        .swipeActions {
                            Button("Delete", role: .destructive) {
                                modelContext.delete(toDo)
                                guard let _ = try? modelContext.save() else {
                                    print("😡 ERROR: Save after .delete on ToDoListView did not work.")
                                    return
                                }
                            }
                        }
                    }
                    .font(.title3)
                    
                    HStack {
                        Text(toDo.dueDate.formatted(date: .abbreviated, time: .shortened))
                            .foregroundStyle(.secondary)
                        
                        if toDo.reminderIsOn {
                            Image(systemName: "calendar.badge.clock")
                                .symbolRenderingMode(.multicolor)
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

struct ToDoListView: View {
    @State private var sheetIsPresented = false
    @State private var sortSelection: SortOption = .asEntered
    
    var body: some View {
        NavigationStack {
            SortedToDoList(sortSelection: sortSelection)
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .sheet(isPresented: $sheetIsPresented) {
                NavigationStack {
                    DetailView(toDo: ToDo())
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sheetIsPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .foregroundStyle(.blue)
                }
                ToolbarItem(placement: .bottomBar) {
                    Picker("", selection: $sortSelection) {
                        ForEach(SortOption.allCases, id: \.self) { sortOrder in
                            Text(sortOrder.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
    }
}

#Preview {
    ToDoListView()
        .modelContainer(ToDo.preview)
}
