//
//  ToDoListRouter.swift
//  ToDoList
//
//  Created by Марк Киричко on 29.05.2023
//

import UIKit

protocol ToDoListRouterProtocol {
    func goToToDoListItemDetail(item: ToDoListItemModel)
}

class ToDoListRouter: ToDoListRouterProtocol {
    
    weak var viewController: ToDoListViewController?
    
    func goToToDoListItemDetail(item: ToDoListItemModel) {
        let vc = ToDoListItemDetailViewController(item: item)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
