//
//  ToDoListPresenter.swift
//  ToDoList
//
//  Created by Марк Киричко on 29.05.2023
//

protocol ToDoListPresenterProtocol: AnyObject {
    func interactorDidFetchedItems(items: [ToDoListItemModel])
    func GetDate()
    func interactorDidFetchedDate(date: String)
    func addToDo(item: ToDoListItemModel)
    func EditToDo(item: ToDoListItemModel, title: String, description: String)
    func DeleteToDo(item: ToDoListItemModel)
    func didChanged()
}

class ToDoListPresenter {
    weak var view: ToDoListViewProtocol?
    var router: ToDoListRouterProtocol
    var interactor: ToDoListInteractorProtocol

    init(interactor: ToDoListInteractorProtocol, router: ToDoListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension ToDoListPresenter: ToDoListPresenterProtocol {
    
    func interactorDidFetchedItems(items: [ToDoListItemModel]) {
        view?.displayToDoListItems(items: items)
    }
    
    func GetDate() {
        interactor.GetToDayDate()
    }
    
    func interactorDidFetchedDate(date: String) {
        view?.displayCurrentDate(date: date)
    }
    
    func addToDo(item: ToDoListItemModel) {
        interactor.saveToDo(item)
    }
    
    func EditToDo(item: ToDoListItemModel, title: String, description: String) {
        interactor.ChangeToDo(item: item, title: title, description: description)
    }
    
    func DeleteToDo(item: ToDoListItemModel) {
        interactor.deleteToDo(item)
    }
    
    func didChanged() {
        interactor.GetToDoListItems()
    }
}
