//
//  ToDoListTabBarController.swift
//  ToDoList
//
//  Created by Марк Киричко on 31.05.2023.
//

import UIKit

class ToDoListTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor.black
        SetUpTabs()
    }
    
    private func SetUpTabs() {
        let vc = ToDoListModuleBuilder.build(
            realmManager: Injection.shared.makeContainer().resolve(RealmManager.self),
            dateManager: Injection.shared.makeContainer().resolve(DateManager.self)
        )
        let navVC = UINavigationController(rootViewController: vc)
        navVC.navigationItem.largeTitleDisplayMode = .automatic
        navVC.tabBarItem = UITabBarItem(title: "список", image: UIImage(systemName: "list.bullet"), selectedImage: UIImage(systemName: "list.bullet"))
        setViewControllers([navVC], animated: true)
    }
}
