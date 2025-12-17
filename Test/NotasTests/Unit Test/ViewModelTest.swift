//
//  ViewModelTest.swift
//  NotasTests
//
//  Created by Emmanuel Cepeda Antillon on 09/12/25.
//

import XCTest

@testable import Notas

final class ViewModelTest: XCTestCase {
    var viewModel: NoteViewModel!
    
    override func setUpWithError() throws {
        viewModel = NoteViewModel(createNoteUseCase: createNoteUseCaseMock(),
                                  fetchNotesUseCase: fetchAllNoteUseCaseMock(),
                                  deleteNoteUseCase: deleteNoteUseCaseMock(),
                                  updateNoteUseCase: updateNoteUseCaseMock())
    }
    
    override func tearDownWithError() throws {
        mockDatabase.removeAll()
    }
    
    func testCreateNote() {
        // Given
        let title = "Test Title"
        let text = "Test Content"
        
        // When
        viewModel.createNote(title: title, text: text)
        
        // Then
        XCTAssertEqual(viewModel.notes.count, 1)
        XCTAssertEqual(viewModel.notes.last?.title, title)
    }
    
    func testUpdateNote() {
        // Given
        let title = "Test Title"
        let text = "Test Content"
        
        // When
        viewModel.createNote(title: title, text: text)
        
        
        XCTAssertEqual(viewModel.notes.count, 1)
        XCTAssertEqual(viewModel.notes.last?.title, title)
        
        let newTitle = "Test Title updated"
        let newText = "Test Content updated"
        
        if let identifier = viewModel.notes.last?.identifier {
            viewModel.updateNoteWith(identifier: identifier, newTitle: newTitle, newText: newText)
        }
        
        // Then
        XCTAssertEqual(viewModel.notes.count, 1)
        XCTAssertEqual(viewModel.notes.last?.title, newTitle)
        XCTAssertEqual(viewModel.notes.last?.getText, newText)
    }
    
    
    func testRemoveNote() {
        // Given
        let title = "Test Title"
        let text = "Test Content"
        
        // When
        viewModel.createNote(title: title, text: text)
        
        XCTAssertEqual(viewModel.notes.count, 1)
        XCTAssertEqual(viewModel.notes.last?.title, title)
        
        if let identifier = viewModel.notes.last?.identifier {
            viewModel.removeNoteWith(identifier: identifier)
        } else {
            XCTFail("Note wasn't created")
        }
       
        // Then
        XCTAssertEqual(viewModel.notes.count, 0)
    }
}
