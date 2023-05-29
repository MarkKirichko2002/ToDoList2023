//
//  ToDoListInteractor.swift
//  ToDoList
//
//  Created by Марк Киричко on 29.05.2023
//

protocol ToDoListInteractorProtocol: AnyObject {
    func GetToDoListItems()
    func saveToDo(_ item: ToDoListItemModel)
    func deleteToDo(_ item: ToDoListItemModel)
}

class ToDoListInteractor: ToDoListInteractorProtocol {
    
    weak var presenter: ToDoListPresenterProtocol?
    private var realmManager: RealmManager?
    
    // MARK: - Init
    init(realmManager: RealmManager?) {
        self.realmManager = realmManager
    }
    
    func GetToDoListItems() {
        guard let realmManager = self.realmManager else {return}
        presenter?.interactorDidFetchedItems(items: realmManager.fetchToDoListItems())
    }
    
    func saveToDo(_ item: ToDoListItemModel) {
        realmManager?.writeData(item: item)
        presenter?.didAddToDo()
    }
    
    func deleteToDo(_ item: ToDoListItemModel) {
        realmManager?.deleteData(item: item)
    }
}
