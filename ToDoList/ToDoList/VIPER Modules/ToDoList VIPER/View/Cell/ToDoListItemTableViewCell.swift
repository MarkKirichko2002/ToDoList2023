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
}

class ToDoListItemTableViewCell: UITableViewCell {
    
    static let identifier = "ToDoListItemTableViewCell"
    weak var delegate: CustomCellDelegate?
    private var item: ToDoListItemModel?
    
    @IBOutlet var TitleLabel: UILabel!
    @IBOutlet var DateLabel: UILabel!
    @IBOutlet var ItemImage: UIImageView!
    
    @IBAction func EditToDoListItem() {
        guard let item = item else {return}
        delegate?.didTapEdit(item: item)
    }
    
    @IBAction func EditToDoListItemImage() {
        guard let item = item else {return}
        delegate?.didTapEditImage(item: item)
    }
    
    func configure(item: ToDoListItemModel) {
        self.item = item
        ItemImage.image = UIImage(data: item.image)
        TitleLabel.text = item.title
        DateLabel.text = item.date
    }
}
