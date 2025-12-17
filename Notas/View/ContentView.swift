//
//  ContentView.swift
//  Notas
//
//  Created by Emmanuel Cepeda Antillon on 12/11/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    var viewModel: NoteViewModel = .init()
    @State var showCreateNote: Bool = false
    @State var editCreateNote: Bool = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.notes) { note in
                    NavigationLink(value: note) {
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.headline)
                                .foregroundStyle(.primary)
                            Text(note.getText)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }

            .toolbar {
                ToolbarItem(placement: .status) {
                    Button("New Note") {
                        self.showCreateNote.toggle()
                    }
                }
            }
            .navigationTitle(Text("Notas"))
            .navigationDestination(for: Note.self, destination: { note in
                UpdateNoteView(viewModel: viewModel, identifier: note.identifier, title: note.title, text: note.getText )
            })
            .fullScreenCover(isPresented: $showCreateNote, content: {
                CreateNoteView(viewModel: viewModel)
            })
        }
    }
}

#Preview {
    ContentView(viewModel: .init(notes: [
        .init(title: "Hello", text: "Hello World", createdAt: .now),
    ]))
}

