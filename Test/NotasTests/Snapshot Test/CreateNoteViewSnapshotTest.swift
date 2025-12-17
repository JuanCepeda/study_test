//
//  CreateNoteViewSnapshotTest.swift
//  NotasTests
//
//  Created by Emmanuel Cepeda Antillon on 17/12/25.
//

import XCTest
import SnapshotTesting

@testable import Notas

final class CreateNoteViewSnapshotTest: XCTestCase {

    func testCreateNoteView() {
        let createViewNote = CreateNoteView(viewModel: .init())
        assertSnapshot(of: createViewNote, as: .image)
    }

    func testCreateNoteWithViewData() {
        let createViewNote = CreateNoteView(viewModel: .init(),
                                            title: "Title",
                                            text: "Text")
        assertSnapshot(of: createViewNote, as: .image)
    }
}
