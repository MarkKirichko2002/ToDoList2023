//
//  ToDoListInteractor.swift
//  ToDoList
//
//  Created by Марк Киричко on 29.05.2023
//

protocol ToDoListInteractorProtocol: AnyObject {
    func GetToDoListItems()
    func GetToDayDate()
    func saveToDo(_ item: ToDoListItemModel)
    func deleteToDo(_ item: ToDoListItemModel)
}

class ToDoListInteractor: ToDoListInteractorProtocol {
    
    weak var presenter: ToDoListPresenterProtocol?
    
    // MARK: - сервисы
    private var realmManager: RealmManager?
    private var dateManager: DateManager?
    
    // MARK: - Init
    init(realmManager: RealmManager?, dateManager: DateManager?) {
        self.realmManager = realmManager
        self.dateManager = dateManager
    }
    
    func GetToDoListItems() {
        guard let realmManager = self.realmManager else {return}
        presenter?.interactorDidFetchedItems(items: realmManager.fetchToDoListItems())
    }
    
    func GetToDayDate() {
        let date = dateManager?.GetCurrentDate() ?? ""
        presenter?.interactorDidFetchedDate(date: date)
    }
    
    func saveToDo(_ item: ToDoListItemModel) {
        realmManager?.writeData(item: item)
        presenter?.didAddToDo()
    }
    
    func deleteToDo(_ item: ToDoListItemModel) {
        realmManager?.deleteData(item: item)
    }
}
