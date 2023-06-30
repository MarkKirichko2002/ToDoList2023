//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by Марк Киричко on 29.05.2023
//

import UIKit

protocol ToDoListViewProtocol: AnyObject {
    func displayCurrentDate(date: String)
    func displayToDoListItems(items: [ToDoListItemModel])
}

class ToDoListViewController: UIViewController {
    
    var items = [ToDoListItemModel]()
    var item: ToDoListItemModel?
    let player = AudioPlayer()
    
    var presenter: ToDoListPresenterProtocol?
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UINib(nibName: ToDoListItemTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ToDoListItemTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Сегодня"
        view.backgroundColor = .systemBackground
        SetUpTable()
        makeAddButton()
        presenter?.getDate()
    }
    
    func openCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    private func SetUpTable() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func makeAddButton() {
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(showAddNewItem))
        addButton.tintColor = .black
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func showAddNewItem() {
        showAddNewItemAlert()
    }
    
    private func showAddNewItemAlert() {
        let alertController = UIAlertController(title: "Добавить новое задание", message: "Введите название и описание", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "Сохранить", style: .default, handler: { [weak self] _ in
            let titleText = alertController.textFields![0].text ?? ""
            let descriptionText = alertController.textFields![1].text ?? ""
            guard !titleText.isEmpty, !descriptionText.isEmpty else { return }
            let item = ToDoListItemModel()
            item.title = titleText
            item.taskDescription = descriptionText
            self?.presenter?.addToDo(item: item)
        }))
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
