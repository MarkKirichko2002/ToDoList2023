//
//  ToDoListItemModel.swift
//  ToDoList
//
//  Created by Марк Киричко on 29.05.2023.
//

import RealmSwift

class ToDoListItemModel: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var taskDescription: String
    @Persisted var date: String
}
