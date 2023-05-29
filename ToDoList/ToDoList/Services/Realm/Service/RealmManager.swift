//
//  RealmManager.swift
//  ToDoList
//
//  Created by Марк Киричко on 29.05.2023.
//

import RealmSwift

class RealmManager {
    
    private let realm = try! Realm()

    private var dateManager: DateManager?
    
    // MARK: - Init
    init(dateManager: DateManager?) {
        self.dateManager = dateManager
    }
    
    func fetchToDoListItems()-> [ToDoListItemModel] {
        var array = [ToDoListItemModel]()
        let items = realm.objects(ToDoListItemModel.self)
        for item in items {
            array.append(item)
        }
        return array
    }
    
    func writeData(item: ToDoListItemModel) {
        let newItem = ToDoListItemModel()
        newItem.title = item.title
        newItem.date = dateManager?.GetCurrentDate() ?? ""
        try! realm.write {
            realm.add(newItem)
        }
    }
    
    func deleteData(item: ToDoListItemModel) {
        let item = realm.object(ofType: ToDoListItemModel.self, forPrimaryKey: item.id)
        guard let item = item else {return}
        try! realm.write {
            realm.delete(item)
        }
    }
}