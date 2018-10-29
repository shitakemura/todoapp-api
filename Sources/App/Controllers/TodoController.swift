import Vapor

/// Controls basic CRUD operations on `Todo`s.
final class TodoController {
    // 全Todoの取得
    func index(_ req: Request) throws -> Future<[Todo]> {
        return Todo.query(on: req).all()
    }

    // Todo追加
    func create(_ req: Request) throws -> Future<Todo> {
        return try req.content.decode(Todo.self).flatMap { todo in
            return todo.save(on: req)
        }
    }
    
    // Todo更新
    func update(_ req: Request) throws -> Future<Todo> {
        return try req.parameters.next(Todo.self).flatMap { todo in
            return try req.content.decode(Todo.self).flatMap { newTodo in
                todo.taskName = newTodo.taskName
                todo.isDone = newTodo.isDone
                return todo.save(on: req)
            }
        }
    }

    // Todo削除
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Todo.self).flatMap { todo in
            return todo.delete(on: req)
        }.transform(to: .ok)
    }

    // Todo全削除
    func clear(_ req: Request) throws -> Future<HTTPStatus> {
        return Todo.query(on: req).delete().transform(to: .ok)
    }
}
