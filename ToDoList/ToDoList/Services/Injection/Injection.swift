//
//  Injection.swift
//  ToDoList
//
//  Created by Марк Киричко on 29.05.2023.
//

import Swinject

final class Injection {
    
    static let shared = Injection()
    
    private init() {}
    
    func makeContainer()->Container {
        // Container
        let container = Container()
        // Date
        container.register(DateManager.self) { _ in
            return DateManager()
        }
        // Realm
        container.register(RealmManager.self) { resolver in
            let realmManager = RealmManager(dateManager: resolver.resolve(DateManager.self))
            return realmManager
        }
        return container
    }
}
