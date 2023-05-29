//
//  DateManager.swift
//  ToDoList
//
//  Created by Марк Киричко on 29.05.2023.
//

import Foundation

class DateManager {
    
    func GetCurrentDate()-> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        let string = formatter.string(from: date)
        return string
    }
}
