//
//  UpdateNoteViewSnapshotTest.swift
//  Notas
//
//  Created by Emmanuel Cepeda Antillon on 17/12/25.
//

import XCTest
import SnapshotTesting

@testable import Notas

final class UpdateNoteViewSnapshotTest: XCTestCase {
    
    func testUpdateNoteView() {
        let noteViewModel = NoteViewModel()
        let view = UpdateNoteView(viewModel: noteViewModel, identifier: UUID())
        assertSnapshot(of: view, as: .image)
    }
}
