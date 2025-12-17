//
//  UpdateNoteView.swift
//  Notas
//
//  Created by Emmanuel Cepeda Antillon on 08/12/25.
//

import SwiftUI

struct UpdateNoteView: View {
    var viewModel: NoteViewModel
    let identifier: UUID
    @State var title: String = ""
    @State var text: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("", text:$title, prompt: Text("Titulo"), axis: .vertical)
                    TextField("", text:$text, prompt: Text("Texto"), axis: .vertical)
                    
                } footer: {
                    Text("UPDATE NOTE")
                }
                Button(action: {
                    viewModel.removeNoteWith(identifier: identifier)
                    dismiss()
                }, label: {
                    Text("Delete Note")
                        .backgroundStyle(Color(.systemRed))
                })
            }
            
            .background(Color(UIColor.systemBackground))
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.updateNoteWith(identifier: identifier, newTitle: title, newText: text)
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                }
            }
            .navigationTitle(Text("Edit Note"))
        }
    }
}

#Preview {
    UpdateNoteView(viewModel: .init(), identifier:.init(), title: "Title" , text: "Text")
}
