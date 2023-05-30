//
//  ToDoListPresenter.swift
//  ToDoList
//
//  Created by Марк Киричко on 29.05.2023
//

protocol ToDoListPresenterProtocol: AnyObject {
    func interactorDidFetchedItems(items: [ToDoListItemModel])
    func getDate()
    func interactorDidFetchedDate(date: String)
    func addToDo(item: ToDoListItemModel)
    func editToDo(item: ToDoListItemModel, title: String, description: String)
    func deleteToDo(item: ToDoListItemModel)
    func didChanged()
    func goToItemDetail(item: ToDoListItemModel)
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
    
    func getDate() {
        interactor.getToDayDate()
    }
    
    func interactorDidFetchedDate(date: String) {
        view?.displayCurrentDate(date: date)
    }
    
    func addToDo(item: ToDoListItemModel) {
        interactor.saveToDo(item)
    }
    
    func editToDo(item: ToDoListItemModel, title: String, description: String) {
        interactor.changeToDo(item: item, title: title, description: description)
    }
    
    func deleteToDo(item: ToDoListItemModel) {
        interactor.deleteToDo(item)
    }
    
    func didChanged() {
        interactor.getToDoListItems()
    }
    
    func goToItemDetail(item: ToDoListItemModel) {
        router.goToToDoListItemDetail(item: item)
    }
}
