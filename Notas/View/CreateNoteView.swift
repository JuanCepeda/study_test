//
//  CreateNoteView.swift
//  Notas
//
//  Created by Emmanuel Cepeda Antillon on 08/12/25.
//

import SwiftUI

struct CreateNoteView: View {
    var viewModel: NoteViewModel
    @State var title: String = ""
    @State var text: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("", text:$title, prompt: Text("Titulo"), axis: .vertical)
                    TextField("", text:$text, prompt: Text("Texto"), axis: .vertical)
                    
                } footer: {
                    Text("El texto es obligatorio")
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("X")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.createNote(title: title, text: text)
                        dismiss()
                    } label: {
                        Text("+")
                    }
                }
            }
            
            .navigationTitle(Text("Nueva Nota"))
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    CreateNoteView(viewModel: .init())
}
