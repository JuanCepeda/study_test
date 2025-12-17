//
//  ViewModelIntegrationTest.swift
//  NotasTests
//
//  Created by Emmanuel Cepeda Antillon on 10/12/25.
//

import XCTest

@testable import Notas

final class ViewModelIntegrationTest: XCTestCase {
    
    var sut: NoteViewModel!

    @MainActor
    override func setUpWithError() throws {
        let dataBase = NoteDatabase.shared
        dataBase.container = NoteDatabase.setupContainer(inMemory: true)
        
        let createNoteUseCase = CreateNoteUseCase(notesDatabase: dataBase)
        let fetchNotesUseCase = FetchAllNotesUseCase(notesDatabase: dataBase)
        
        sut = NoteViewModel(createNoteUseCase: createNoteUseCase,
                            fetchNotesUseCase: fetchNotesUseCase)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreateNote() {
        // Given
        sut.createNote(title: "Test", text: "Text")
        
        
        // When
        let note = sut.notes.first
        
        // Then
        XCTAssertEqual(sut.notes.count, 1)
        XCTAssertEqual(note?.title, "Test")
        XCTAssertEqual(note?.text, "Text")
        XCTAssertNotNil(note)
    }
    
    func testCreateTwoNote() {
        // Given
        sut.createNote(title: "Test", text: "Text")
        sut.createNote(title: "Test 2", text: "Text 2")
        
        
        // When
        let note = sut.notes.first
        let note2 = sut.notes.last
        
        // Then
        XCTAssertEqual(sut.notes.count, 2)
        XCTAssertEqual(note?.title, "Test")
        XCTAssertEqual(note?.text, "Text")
        XCTAssertNotNil(note)
        
        XCTAssertEqual(note2?.title, "Test 2")
        XCTAssertEqual(note2?.text, "Text 2")
        XCTAssertNotNil(note2)
    }
    
    func testFetchAllNotes() {
        // Given
        sut.createNote(title: "Test", text: "Text")
        sut.createNote(title: "Test 2", text: "Text 2")
        
        // When
        let note = sut.notes.first
        let note2 = sut.notes.last
        
        // Then
        XCTAssertEqual(sut.notes.count, 2)
        XCTAssertEqual(note?.title, "Test")
        XCTAssertEqual(note?.text, "Text")
        XCTAssertNotNil(note)
        
        XCTAssertEqual(note2?.title, "Test 2")
        XCTAssertEqual(note2?.text, "Text 2")
        XCTAssertNotNil(note2)
        
    }
    
    func testUpdateNote() {
        sut.createNote(title: "Test", text: "Test" )
        
        guard let note = sut.notes.first else {
            XCTFail( "No note found")
            return
        }
        sut.updateNoteWith(identifier: note.identifier, newTitle: "new title", newText: "New Text")
   
        XCTAssertEqual(note.title, "new title")
        XCTAssertEqual(note.text,  "New Text")
    }
    
    func testDeleteNoteInDatabaseShouldThrowError() {
        sut.removeNoteWith(identifier: UUID())
        XCTAssert(sut.notes.isEmpty)
        XCTAssertNotNil(sut.databaseError)
        XCTAssertEqual(sut.databaseError, NoteDatabaseError.errorDelete)
    }
}
