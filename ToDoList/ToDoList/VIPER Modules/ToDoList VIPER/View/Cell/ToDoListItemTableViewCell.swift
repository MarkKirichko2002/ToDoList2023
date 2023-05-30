//
//  ToDoListItemTableViewCell.swift
//  ToDoList
//
//  Created by Марк Киричко on 30.05.2023.
//

import UIKit

protocol CustomCellDelegate: AnyObject {
    func didTapEdit(item: ToDoListItemModel)
    func didTapEditImage(item: ToDoListItemModel)
    func didTapCompleteStatus(item: ToDoListItemModel, complete: Bool)
}

class ToDoListItemTableViewCell: UITableViewCell {
    
    static let identifier = "ToDoListItemTableViewCell"
    weak var delegate: CustomCellDelegate?
    private var item: ToDoListItemModel?
    private var isCompleted = false

    @IBOutlet var TitleLabel: UILabel!
    @IBOutlet var DateLabel: UILabel!
    @IBOutlet var ItemImage: UIImageView!
    @IBOutlet var ItemComplete: UIButton!
    
    @IBAction func EditToDoListItem() {
        guard let item = item else {return}
        delegate?.didTapEdit(item: item)
    }
    
    @IBAction func EditToDoListItemImage() {
        guard let item = item else {return}
        delegate?.didTapEditImage(item: item)
    }
    
    @IBAction func ToggleCompleteStatus() {
        guard let item = item else {return}
        if isCompleted == false {
            isCompleted = true
            delegate?.didTapCompleteStatus(item: item, complete: isCompleted)
        } else {
            isCompleted = false
            delegate?.didTapCompleteStatus(item: item, complete: isCompleted)
        }
    }
    
    func configure(item: ToDoListItemModel) {
        self.item = item
        ItemImage.image = UIImage(data: item.image) ?? UIImage(systemName: "list.bullet.circle")
        TitleLabel.text = item.title
        DateLabel.text = item.date
        ItemComplete.setImage(UIImage(systemName: item.complete ? "checkmark.circle.fill" : "checkmark.circle"), for: .normal)
    }
}
