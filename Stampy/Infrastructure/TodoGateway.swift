//
//  TodoGateway.swift
//  Stampy
//
//  Created by 保坂篤志 on 2024/11/15.
//

import Foundation
import FirebaseFirestore

class TodoGateway: TodoGatewayProtocol {
    private let db = Firestore.firestore()
    
    func fetchTodos(goal_id: String) async -> [TodoRecord] {
        do {
            let snapshot = try await db.collection("todos")
                .whereField("goal_id", isEqualTo: goal_id)
                .getDocuments()
            return try snapshot.documents.map { try $0.data(as: TodoRecord.self) }
        } catch {
            return []
        }
    }
    
    func addTodo(todoRecord: TodoRecord) async {
        do {
            try db.collection("todos").document(todoRecord.id).setData(from: todoRecord)
        } catch {
            print(error)
        }
    }
    
    func updateTodo(todo_id: String, title: String, status: String) async {
        do {
            try await db.collection("todos").document(todo_id).updateData([
                "title": title,
                "status": status
            ])
        } catch {
            print(error)
        }
    }
    
    func deleteTodo(todo_id: String) async {
        do {
            try await db.collection("todos").document(todo_id).delete()
        } catch {
            print(error)
        }
    }
}
