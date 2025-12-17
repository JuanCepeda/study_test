//
//  NotasTests.swift
//  NotasTests
//
//  Created by Emmanuel Cepeda Antillon on 09/12/25.
//

import XCTest

@testable import Notas

final class NoteTest: XCTestCase {
    
    func testNoteInitialization() {
        // Given
        let title = "Test Note"
        let text = "This is a test note"
        let date = Date()
        
        // When or Act
        let note = Note(title: title, text: text, createdAt: date)
        
        // Then or Assert
        XCTAssertEqual(title, note.title)
        XCTAssertEqual(text, note.text)
        XCTAssertEqual(date, note.createdAt)
        
    }
    
    func testEmpyNoteInitialization() {
        // Given
        let title: String = ""
        let date = Date()
        
        // When or Act
        let note = Note(title: title, text: nil, createdAt: date)
        
        // Then or Assert
        XCTAssertEqual(note.getText, "")
    }
}
