//
//  Mocks.swift
//  NotasTests
//
//  Created by Emmanuel Cepeda Antillon on 16/12/25.
//

import XCTest
import Foundation

@testable import Notas

var mockDatabase: [Note] = []

struct fetchAllNoteUseCaseMock: FetchAllNotesProtocol {
    func fetchAll() throws -> [Notas.Note] {
        return mockDatabase
    }
}

struct createNoteUseCaseMock: CreateNoteProtocol {
    func createNoteWith(title: String, text: String) throws {
        let note = Note(title: title, text: text, createdAt: .now)
        mockDatabase.append(note)
        print("Note Created")
    }
}

struct deleteNoteUseCaseMock: DeleteNoteProtocol {
    func deleteNote(identifier: UUID) {
        mockDatabase.removeLast()
    }
}

struct updateNoteUseCaseMock: UpdateNotesProtocol {
        func update(identifier: UUID, updateText: String, updateTitle: String) throws {
        mockDatabase.last?.title = updateTitle
        mockDatabase.last?.text = updateText
    }
}
