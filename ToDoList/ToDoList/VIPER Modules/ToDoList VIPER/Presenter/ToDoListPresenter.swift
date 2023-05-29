//
//  ToDoListPresenter.swift
//  ToDoList
//
//  Created by Марк Киричко on 29.05.2023
//

protocol ToDoListPresenterProtocol: AnyObject {
    func interactorDidFetchedItems(items: [ToDoListItemModel])
    func addToDo(item: ToDoListItemModel)
    func DeleteToDo(item: ToDoListItemModel)
    func didAddToDo()
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
    
    func addToDo(item: ToDoListItemModel) {
        interactor.saveToDo(item)
    }
    
    func DeleteToDo(item: ToDoListItemModel) {
        interactor.deleteToDo(item)
    }
    
    func didAddToDo() {
        interactor.GetToDoListItems()
    }
}
