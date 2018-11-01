//
//  MusicHelper.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 01/11/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation
import SpriteKit

class MusicHelper {
    
    static func fadeIn(onAudio audio: SKAudioNode, withDuration duration : TimeInterval = 2) {
        audio.run(SKAction.fadeIn(withDuration: duration))
    }
    
    static func fadeOut(onAudio audio: SKAudioNode, withDuration duration : TimeInterval = 2) {
        audio.run(SKAction.fadeOut(withDuration: duration))
    }
    
    static func startSounds(withAudios audios: [SKNode], withVolume volume: Float = 0.8) {
        
        for a in audios{
            if let audio = a as? SKAudioNode{
                self.changeVolume(ofAudio: audio, to: volume)
                self.fadeIn(onAudio: audio)
                self.changeVolume(ofAudio: audio, to: volume, withDuration: 1)
            }
        }
        
    }
    
    static func stopSounds(withAudios audios: [SKNode]){
        for a in audios{
            if let audio = a as? SKAudioNode{
                self.fadeOut(onAudio: audio)
                self.changeVolume(ofAudio: audio, to: 0, withDuration: 1)
            }
        }
    }
    
    static func changeVolume(ofAudio audio: SKAudioNode, to volume: Float, withDuration duration : TimeInterval = 0){
        audio.run(SKAction.changeVolume(to: volume, duration: duration))
    }
}
