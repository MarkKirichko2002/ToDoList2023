//
//  AudioPlayer.swift
//  ToDoList
//
//  Created by Марк Киричко on 31.05.2023.
//

import AVFoundation

class AudioPlayer {
    
    var player: AVAudioPlayer!
    
    func playSound(path: String) {
        
        if let audioUrl = URL(string: path) {
            
            // then lets create your document folder url
            let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            // lets create your destination file url
            let destinationUrl = documentsDirectoryURL.appendingPathComponent(audioUrl.lastPathComponent)
            
            do {
                player = try AVAudioPlayer(contentsOf: destinationUrl)
                guard let player = player else { return }
                
                player.prepareToPlay()
                player.play()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
