//
//  BackgroundMusicControler.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 17/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation

class BackgroundMusicController {
    var musicName: String
    var soundController: Sound?
    
    init(musicName: String, musicExtension: String = "wav"){
        self.musicName = musicName
        self.soundController = Sound(url: Bundle.main.url(forResource: musicName, withExtension: musicExtension)!)
    }
    
    func startMusic(withVolume volume: Float){
        if(soundController != nil){
            soundController!.volume = volume
            soundController!.play(numberOfLoops: -1, completion: nil)
        }
    }
    
    func changeMusic(to musicName: String, musicExtension: String = "wav", withVolume volume: Float){
        if (soundController != nil){
            self.soundController!.stop()
            self.soundController = Sound(url: Bundle.main.url(forResource: musicName, withExtension: musicExtension)!)
            self.soundController!.volume = volume
            self.soundController!.play(numberOfLoops: -1, completion: nil)
        }
        
    }
}
