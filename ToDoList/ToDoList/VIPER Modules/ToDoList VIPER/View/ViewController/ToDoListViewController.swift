//
//  ToDoListViewController.swift
//  ToDoList
//
//  Created by Марк Киричко on 29.05.2023
//

import UIKit
import MobileCoreServices

protocol ToDoListViewProtocol: AnyObject {
    func displayCurrentDate(date: String)
    func displayToDoListItems(items: [ToDoListItemModel])
}

class ToDoListViewController: UIViewController {
    
    private var items = [ToDoListItemModel]()
    private var item: ToDoListItemModel?
    let player = AudioPlayer()
    
    var presenter: ToDoListPresenterProtocol?
    
    private let tableView: UITableView = {
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
    
    private func openCamera() {
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

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        player.playSound(path: items[indexPath.row].sound)
        presenter?.goToItemDetail(item: items[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoListItemTableViewCell.identifier, for: indexPath) as? ToDoListItemTableViewCell else {fatalError()}
        cell.configure(item: items[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.deleteToDo(item: items[indexPath.row])
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

// MARK: - CustomCellDelegate
extension ToDoListViewController: CustomCellDelegate {
    
    func didTapEdit(item: ToDoListItemModel) {
        let alertController = UIAlertController(title: "Изменить задание", message: "Вы хотите изменить задание?", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(UIAlertAction(title: "Сохранить", style: .default, handler: { [weak self] _ in
            let titleText = alertController.textFields![0].text!
            let descriptionText = alertController.textFields![1].text!
            if !titleText.isEmpty {
                self?.presenter?.editToDo(item: item, title: titleText, description: item.taskDescription)
            } else if !descriptionText.isEmpty {
                self?.presenter?.editToDo(item: item, title: item.title, description: descriptionText)
            } else {
                self?.presenter?.editToDo(item: item, title: item.title, description: item.taskDescription)
            }
        }))
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func didTapEditImage(item: ToDoListItemModel) {
        self.item = item
        openCamera()
    }
    
    func didTapEditSound(item: ToDoListItemModel) {
        self.item = item
        let fileService = FileService()
        fileService.delegate = self
        fileService.vc = self
        fileService.importFiles()
    }
    
    func didTapCompleteStatus(item: ToDoListItemModel, complete: Bool) {
        presenter?.editToDoCompleteStatus(item: item, complete: complete)
    }
    
    func didTapDelete(item: ToDoListItemModel) {
        presenter?.deleteToDo(item: item)
    }
}

// MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate
extension ToDoListViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        
        if let item = item {
            presenter?.editToDoImage(item: item, image: image)
        }
    }
}

// MARK: - UIDocumentPickerDelegate
extension ToDoListViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
       
        guard let selectedFileURL = urls.first else {
            return
        }
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
          
            do {
                print("уже есть")
                guard let item = self.item else {return}
                presenter?.editToDoSound(item: item, path: sandboxFileURL)
            } catch {
                print(error)
            }
            
        } else {
            
            do {
                print("copied dile")
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                guard let item = self.item else {return}
                presenter?.editToDoSound(item: item, path: sandboxFileURL)
            } catch {
                print("Ошибка: \(error)")
            }
        }
    }
}
