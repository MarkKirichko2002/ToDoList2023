//
//  ToDoListItemTableViewCell.swift
//  ToDoList
//
//  Created by Марк Киричко on 30.05.2023.
//

import UIKit

class ToDoListItemTableViewCell: UITableViewCell {
    
    static let identifier = "ToDoListItemTableViewCell"
    
    @IBOutlet var TitleLabel: UILabel!
    @IBOutlet var DateLabel: UILabel!
    @IBOutlet var CompleteStatus: UIButton!
    
    func configure(item: ToDoListItemModel) {
        TitleLabel.text = item.title
        DateLabel.text = item.date
        CompleteStatus.setImage(UIImage(systemName: item.complete ? "checkmark.circle.fill" : "checkmark.circle"), for: .normal)
    }
}
