//
//  FetchAllNotesUseCase.swift
//  Notas
//
//  Created by Emmanuel Cepeda Antillon on 09/12/25.
//

import Foundation

protocol FetchAllNotesProtocol {
    func fetchAll() throws -> [Note]
}

struct FetchAllNotesUseCase: FetchAllNotesProtocol {
    var notesDatabase: NoteDatabaseProtocol
    
    init(notesDatabase: NoteDatabaseProtocol = NoteDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func fetchAll() throws -> [Note] {
        try notesDatabase.fetchAll()
    }
}
