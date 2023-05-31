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
    func didTapEditSound(item: ToDoListItemModel)
    func didTapCompleteStatus(item: ToDoListItemModel, complete: Bool)
    func didTapDelete(item: ToDoListItemModel)
}

class ToDoListItemTableViewCell: UITableViewCell {
    
    static let identifier = "ToDoListItemTableViewCell"
    weak var delegate: CustomCellDelegate?
    private var item: ToDoListItemModel?
    private var isCompleted = false
    
    @IBOutlet var TitleLabel: UILabel!
    @IBOutlet var DateLabel: UILabel!
    @IBOutlet var ItemImage: InteractiveImageView!
    @IBOutlet var ItemComplete: UIButton!
    @IBOutlet var ContextButton: UIButton!
    
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
        ItemImage.sound = item.sound
        TitleLabel.text = item.title
        DateLabel.text = item.date
        ItemComplete.setImage(UIImage(systemName: item.complete ? "checkmark.circle.fill" : "checkmark.circle"), for: .normal)
        setUpContextMenu()
    }
    
    private func setUpContextMenu() {
        // редактировать элемента
        let edit = UIAction(title: "редактировать", image: UIImage(systemName: "square.and.pencil")) { _ in
            guard let item = self.item else {return}
            DispatchQueue.main.async {
                self.delegate?.didTapEdit(item: item)
            }
        }
        // редактировать фото
        let editImage = UIAction(title: "фото", image: UIImage(systemName: "photo")) { _ in
            guard let item = self.item else {return}
            DispatchQueue.main.async {
                self.delegate?.didTapEditImage(item: item)
            }
        }
        // редактировать звук
        let editSound = UIAction(title: "звук", image: UIImage(systemName: "music.note")) { _ in
            guard let item = self.item else {return}
            DispatchQueue.main.async {
                self.delegate?.didTapEditSound(item: item)
            }
        }
        // удалить элемента
        let delete = UIAction(title: "удалить", image: UIImage(systemName: "trash")) { _ in
            guard let item = self.item else {return}
            DispatchQueue.main.async {
                self.delegate?.didTapDelete(item: item)
            }
        }
        ContextButton.showsMenuAsPrimaryAction = true
        ContextButton.menu = UIMenu(title: "", children: [edit, editImage, editSound, delete])
    }
}
