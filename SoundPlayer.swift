//
//  SoundPlayer.swift
//  Timer
//
//  Created by James Wood on 2017/09/01.
//  Copyright © 2017 James Wood. All rights reserved.
//
//
//


import Foundation
import AVFoundation


protocol SoundPlayerDelegate {
    func didFinishPlaying()
}


class SoundPlayer: NSObject, AVAudioPlayerDelegate {
    
    
    var avPlayer: AVAudioPlayer?
    var fileExtension = "mp3"
    var delegate: SoundPlayerDelegate?
    var fileName: String?
    var pauseBetweenPlayers: Double = 0.0
    var soundDuration: Double?
    
//    Cool syntax!  optional function
//    var onPlay: (() -> Double)?
    

    override init() {
        super.init()
    }
    
    
    func play(randomFrom array: [Any]) {
        
        
        play("alarm2", doesRepeat: true)
        
        
//        // picking a random index
//        let randIndex = Int(arc4random_uniform(UInt32(array.count)))
//        
//        
//        // converting to String (goddamned syntax!)
//        let item = String(describing: array[randIndex])
//        
//        
//        // ... and finally playing it (calling the other play() function)
//        play(item, doesRepeat: true)
    }
    
    
    func play(_ fileName: String, ofType type: String = "mp3", doesRepeat: Bool = false) {
        
        
        // saving the fileName as an attribute
        self.fileName = fileName
        self.fileExtension = type

        
        if let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
            do {
                avPlayer = try AVAudioPlayer(contentsOf: url)
                if let player = avPlayer {
                    player.delegate = self
                    if doesRepeat {
                        player.numberOfLoops = -1
                    }
                    player.play()
                    soundDuration = player.duration
                }
            } catch let error as NSError {
                print("Error!")
                print(error.description)
            }
        } else {
            print("File \(fileName) couldn't be loaded!")
        }
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        delegate?.didFinishPlaying()
    }
    
    
    func stop() {
        avPlayer?.stop()
    }
}












