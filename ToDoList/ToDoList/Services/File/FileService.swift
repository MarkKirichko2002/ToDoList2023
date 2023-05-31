//
//  FileService.swift
//  ToDoList
//
//  Created by Марк Киричко on 31.05.2023.
//

import MobileCoreServices
import UIKit

class FileService {
    
    weak var delegate: UIDocumentPickerDelegate?
    var vc: UIViewController?
    
    func importFiles() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeAudio as String], in: .import)
        documentPicker.delegate = delegate
        documentPicker.allowsMultipleSelection = false
        vc?.present(documentPicker, animated: true)
    }
}
