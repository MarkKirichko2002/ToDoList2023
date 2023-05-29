//
//  ToDoListModuleBuilder.swift
//  ToDoList
//
//  Created by Марк Киричко on 29.05.2023
//

import UIKit

class ToDoListModuleBuilder {
    static func build(realmManager: RealmManager?) -> ToDoListViewController {
        let interactor = ToDoListInteractor(realmManager: realmManager)
        let router = ToDoListRouter()
        let presenter = ToDoListPresenter(interactor: interactor, router: router)
        let viewController = ToDoListViewController()
        presenter.view = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        interactor.GetToDoListItems()
        router.viewController = viewController
        return viewController
    }
}
