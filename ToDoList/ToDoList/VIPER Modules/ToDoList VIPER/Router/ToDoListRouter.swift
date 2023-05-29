//
//  ToDoListRouter.swift
//  ToDoList
//
//  Created by Марк Киричко on 29.05.2023
//

import UIKit

protocol ToDoListRouterProtocol {
    func goToAddNewItemScreen()
}

class ToDoListRouter: ToDoListRouterProtocol {
    weak var viewController: ToDoListViewController?
    
    func goToAddNewItemScreen() {
       
    }
}
