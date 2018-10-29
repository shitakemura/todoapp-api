import FluentSQLite
import Vapor

/// A single entry of a Todo list.
final class Todo: SQLiteModel {
    var id: Int?
    var taskName: String
    var isDone: Bool        // チェックあり・なし
    
    init(id: Int? = nil, title: String, isDone: Bool) {
        self.id = id
        self.taskName = title
        self.isDone = isDone
    }
}

/// Allows `Todo` to be used as a dynamic migration.
extension Todo: Migration { }

/// Allows `Todo` to be encoded to and decoded from HTTP messages.
extension Todo: Content { }

/// Allows `Todo` to be used as a dynamic parameter in route definitions.
extension Todo: Parameter { }
