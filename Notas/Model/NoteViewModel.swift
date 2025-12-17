//
//  NoteViewModel.swift
//  Notas
//
//  Created by Emmanuel Cepeda Antillon on 12/11/25.
//

import Foundation
import Observation

@Observable
class NoteViewModel {
    
    var notes: [Note]
    var databaseError: NoteDatabaseError?
    
    var createNoteUseCase: CreateNoteProtocol
    var fetchNotesUseCase: FetchAllNotesProtocol
    var deleteNoteUseCase: DeleteNoteProtocol
    var updateNoteUseCase: UpdateNotesProtocol
    
    init(notes: [Note] = [],
         createNoteUseCase: CreateNoteProtocol = CreateNoteUseCase(),
         fetchNotesUseCase: FetchAllNotesProtocol = FetchAllNotesUseCase(),
         deleteNoteUseCase: DeleteNoteProtocol = DeleteNoteUseCase(),
         updateNoteUseCase: UpdateNotesProtocol = UpdateNotesUseCase()) {
        self.notes = notes
        self.createNoteUseCase = createNoteUseCase
        self.fetchNotesUseCase = fetchNotesUseCase
        self.deleteNoteUseCase = deleteNoteUseCase
        self.updateNoteUseCase = updateNoteUseCase
        fetchAllNotes()
    }
    
    func createNote(title: String, text: String) {
        do {
            try createNoteUseCase.createNoteWith(title: title, text: text)
            fetchAllNotes()
        } catch {
            print(NoteDatabaseError.errorInsert)
        }
    }
    
    func fetchAllNotes() {
        do {
            notes = try fetchNotesUseCase.fetchAll()
        } catch {
            print(NoteDatabaseError.errorInsert)
        }
    }
    
    func updateNoteWith(identifier: UUID, newTitle: String, newText: String) {
        do {
            try updateNoteUseCase.update(identifier: identifier, updateText: newText, updateTitle: newTitle)
            fetchAllNotes()
        } catch {
            print(NoteDatabaseError.errorUpdate)
        }
    }
    
    func removeNoteWith(identifier: UUID) {
        do {
            try deleteNoteUseCase.deleteNote(identifier: identifier)
            fetchAllNotes()
        } catch let error as NoteDatabaseError {
            print(NoteDatabaseError.errorDelete)
            databaseError = error
        } catch {
            print(NoteDatabaseError.errorDelete)
        }
    }
}
