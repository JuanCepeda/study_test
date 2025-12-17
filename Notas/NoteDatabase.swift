import Foundation
import SwiftData

enum NoteDatabaseError: Error {
    case unknown
    case errorFetch
    case errorUpdate
    case errorInsert
    case errorDelete
}

protocol NoteDatabaseProtocol {
    func insert(note: Note) throws
    func fetchAll() throws -> [Note]
    func deleteNote(note: Note) throws
    func update(note: Note, updatedNote: Note) throws
}

actor NoteDatabase: NoteDatabaseProtocol {
    static let shared: NoteDatabase = NoteDatabase()
    
    @MainActor
    var container: ModelContainer = setupContainer(inMemory: false)
    
    private init() { }
    
    @MainActor
    static func setupContainer(inMemory: Bool) -> ModelContainer {
        do {
            let container = try ModelContainer(for: Note.self,
                                               configurations: ModelConfiguration(isStoredInMemoryOnly: inMemory))
            container.mainContext.autosaveEnabled = true
            return container
        } catch {
            print(error)
            fatalError("Failed to create container")
        }
    }
    
    @MainActor
    func insert(note: Note) throws {
        container.mainContext.insert(note)
        do {
            try container.mainContext.save()
        } catch {
            print(error)
            throw NoteDatabaseError.errorInsert
        }
    }
    
    @MainActor
    func fetchAll() throws -> [Note] {
        
        let fetchDescriptor = FetchDescriptor<Note>(sortBy: [SortDescriptor<Note>(\.createdAt)])
        do {
            return try container.mainContext.fetch(fetchDescriptor)
        } catch {
            print(error)
            throw NoteDatabaseError.errorFetch
        }
    }
    
    @MainActor
    func deleteNote(note: Note) throws {
        container.mainContext.delete(note)
    }
    
    @MainActor
    func update(note: Note, updatedNote: Note) throws {
        try deleteNote(note: note)
        do {
            try insert(note: updatedNote)
        }
        catch {
            throw NoteDatabaseError.errorUpdate
        }
    }
}
