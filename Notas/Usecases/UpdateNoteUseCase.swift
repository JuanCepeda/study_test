import Foundation

protocol UpdateNotesProtocol {
    func update(identifier: UUID, updateText: String, updateTitle: String) throws
}

struct UpdateNotesUseCase: UpdateNotesProtocol {
    var notesDatabase: NoteDatabaseProtocol
    
    init(notesDatabase: NoteDatabaseProtocol = NoteDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func update(identifier: UUID, updateText: String, updateTitle: String) throws {
        let notes = notesDatabase.fetchAll
       do {
           let note = try notes().first(where: { $0.identifier == identifier })
               note?.title = updateTitle
               note?.text = updateText
       } catch {
           print(error)
       }
    }
}
