//
//  DeleteNoteUseCase.swift
//  Notas
//
//  Created by Emmanuel Cepeda Antillon on 10/12/25.
//

import Foundation

protocol DeleteNoteProtocol {
    func deleteNote(identifier: UUID) throws
}

struct DeleteNoteUseCase: DeleteNoteProtocol {
    var notesDatabase: NoteDatabaseProtocol
    
    init(notesDatabase: NoteDatabaseProtocol = NoteDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func deleteNote(identifier: UUID) throws {
        let notes = notesDatabase.fetchAll
        do {
            if let note = try notes().first(where: { $0.identifier == identifier }) {
                do {
                    try notesDatabase.deleteNote(note: note)
                } catch {
                    throw NoteDatabaseError.errorDelete
                }
            }
            else {
                throw NoteDatabaseError.errorDelete
            }
        } catch {
            throw NoteDatabaseError.errorDelete
        }
    }
}

