//
//  ToDoListInteractor.swift
//  ToDoList
//
//  Created by Марк Киричко on 29.05.2023
//

import UIKit

protocol ToDoListInteractorProtocol: AnyObject {
    func getToDoListItems()
    func getToDayDate()
    func saveToDo(_ item: ToDoListItemModel)
    func changeToDo(item: ToDoListItemModel, title: String, description: String)
    func changeToDoImage(item: ToDoListItemModel, image: UIImage)
    func changeToDoCompleteStatus(item: ToDoListItemModel, complete: Bool)
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
    
    func getToDoListItems() {
        guard let realmManager = self.realmManager else {return}
        presenter?.interactorDidFetchedItems(items: realmManager.fetchToDoListItems())
    }
    
    func getToDayDate() {
        let date = dateManager?.GetCurrentDate() ?? ""
        presenter?.interactorDidFetchedDate(date: date)
    }
    
    func saveToDo(_ item: ToDoListItemModel) {
        realmManager?.writeData(item: item)
        presenter?.didChanged()
    }
    
    func changeToDo(item: ToDoListItemModel, title: String, description: String) {
        realmManager?.changeItem(item: item, title: title, description: description)
        presenter?.didChanged()
    }
    
    func changeToDoImage(item: ToDoListItemModel, image: UIImage) {
        realmManager?.uploadImage(item: item, image: image)
        presenter?.didChanged()
    }
    
    func changeToDoCompleteStatus(item: ToDoListItemModel, complete: Bool) {
        realmManager?.changeItemCompleteStatus(item: item, complete: complete)
        presenter?.didChanged()
    }
    
    func deleteToDo(_ item: ToDoListItemModel) {
        realmManager?.deleteData(item: item)
        presenter?.didChanged()
    }
}
