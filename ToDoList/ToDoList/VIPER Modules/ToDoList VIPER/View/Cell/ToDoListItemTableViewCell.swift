//
//  ToDoListItemTableViewCell.swift
//  ToDoList
//
//  Created by Марк Киричко on 30.05.2023.
//

import UIKit

protocol CustomCellDelegate: AnyObject {
    func didTapInfo(item: ToDoListItemModel)
    func didTapEdit(item: ToDoListItemModel)
}

class ToDoListItemTableViewCell: UITableViewCell {
    
    static let identifier = "ToDoListItemTableViewCell"
    weak var delegate: CustomCellDelegate?
    private var item: ToDoListItemModel?
    
    @IBOutlet var TitleLabel: UILabel!
    @IBOutlet var DateLabel: UILabel!
    @IBOutlet var InfoButton: UIButton!
    
    @IBAction func ShowToDoListItemInfo() {
        guard let item = item else {return}
        delegate?.didTapInfo(item: item)
    }
    
    @IBAction func EditToDoListItem() {
        guard let item = item else {return}
        delegate?.didTapEdit(item: item)
    }
    
    func configure(item: ToDoListItemModel) {
        self.item = item
        TitleLabel.text = item.title
        DateLabel.text = item.date
    }
}
