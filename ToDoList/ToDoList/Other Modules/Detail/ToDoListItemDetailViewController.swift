//
//  ToDoListItemDetailViewController.swift
//  ToDoList
//
//  Created by Марк Киричко on 30.05.2023.
//

import UIKit

class ToDoListItemDetailViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "list.bullet.circle")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let TitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let DescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 14, weight: .bold)
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let item: ToDoListItemModel
    
    // MARK: - Init
    init(item: ToDoListItemModel) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(TitleLabel)
        view.addSubview(DescriptionTextView)
        SetUpConstraints()
        imageView.image = UIImage(data: item.image)
        TitleLabel.text = item.title
        DescriptionTextView.text = item.taskDescription
    }
    
    private func SetUpConstraints() {
        NSLayoutConstraint.activate([
            // изображение
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            // дата
            TitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            TitleLabel.heightAnchor.constraint(equalToConstant: 30),
            TitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            TitleLabel.bottomAnchor.constraint(equalTo: DescriptionTextView.topAnchor),
            // описание
            DescriptionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            DescriptionTextView.heightAnchor.constraint(equalToConstant: 300),
            DescriptionTextView.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor, constant: 15),
            DescriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            DescriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            DescriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
