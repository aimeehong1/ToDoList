//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Aimee Hong on 10/13/24.
//

import SwiftUI

struct ToDoListView: View {
    var toDos = ["Learn Swift",
                 "Build an App",
                 "Change the world",
                 "Bring the awesome",
                 "Take a vacation"]
    var body: some View {
        NavigationStack {
            List {
                ForEach(toDos, id: \.self) { toDo in
                    NavigationLink {
                        DetailView(passedValue: toDo)
                    } label: {
                        Text(toDo)
                    }
                }
            }
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
        }
    }
}

#Preview {
    ToDoListView()
}
