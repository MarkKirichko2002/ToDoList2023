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
    
    private var items = [ToDoListItemModel]()
    
    var presenter: ToDoListPresenterProtocol?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Сегодня"
        view.backgroundColor = .systemBackground
        SetUpTable()
        makeAddButton()
        presenter?.GetDate()
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

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Изменить задание", message: "Вы хотите изменить задание?", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "Сохранить", style: .default, handler: { [weak self] _ in
            let titleText = alertController.textFields![0].text ?? ""
            let descriptionText = alertController.textFields![1].text ?? ""
            guard !titleText.isEmpty, !descriptionText.isEmpty, let items = self?.items[indexPath.row] else { return }
            self?.presenter?.EditToDo(item: items, title: titleText, description: descriptionText)
        }))
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "задание: \(items[indexPath.row].title) дата: \(items[indexPath.row].date)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.DeleteToDo(item: items[indexPath.row])
            self.items.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - ToDoListViewProtocol
extension ToDoListViewController: ToDoListViewProtocol {
    
    func displayToDoListItems(items: [ToDoListItemModel]) {
        DispatchQueue.main.async {
            self.items = items
            self.tableView.reloadData()
        }
    }
    
    func displayCurrentDate(date: String) {
        DispatchQueue.main.async {
            self.navigationItem.title = "Сегодня: \(date)"
        }
    }
}
