//
//  InteractiveImageView.swift
//  ToDoList
//
//  Created by Марк Киричко on 31.05.2023.
//

import UIKit

class InteractiveImageView: UIImageView {
    
    private let player = AudioPlayer()
    private let animation = AnimationManager()
    var sound = ""
    
    override func layoutSubviews() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    
    @objc private func tapFunction(sender: UITapGestureRecognizer) {
        player.playSound(path: sound)
        animation.SpringAnimation(view: self)
    }
}
