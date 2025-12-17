//
//  CreateNoteUseCase.swift
//  Notas
//
//  Created by Emmanuel Cepeda Antillon on 09/12/25.
//

import Foundation

protocol CreateNoteProtocol {
    func createNoteWith(title: String, text: String) throws
}

struct CreateNoteUseCase: CreateNoteProtocol {
    var notesDatabase: NoteDatabaseProtocol
    
    init(notesDatabase: NoteDatabaseProtocol = NoteDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func createNoteWith(title: String, text: String) throws {
        let note = Note(identifier: .init(), title: title, text: text, createdAt: .now)
        try notesDatabase.insert(note: note)
    }
}
