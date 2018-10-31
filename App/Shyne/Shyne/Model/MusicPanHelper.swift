//
//  MusicPanHelper.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 31/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation
import SpriteKit

class MusicPanHelper {
    
    static func prepareForPan(thisScne scene: SKScene , forThisListner listner: SKNode, fromThisMusics musics: [SKNode]){
        
        // Listner of scene is a Node passed from param
        scene.listener = listner
        
        // Set to 0 all volumes of musics POSITIONALS, just for start
        for m in musics{
            
            if let music: SKAudioNode = m as? SKAudioNode{
                print("MUSIC NODE \(music)")
                let initial = SKAction.changeVolume(to: 0, duration: 0)
                let playInitial = SKAction.play()
                let sequence = SKAction.sequence([initial, playInitial])
                music.autoplayLooped = true // Loop the sound
                music.run(sequence)
            }
            
        }
        
    }
    
    static func updateMusicPan(inSpace space: CGSize, forThisListner listnerNode: SKNode, fromThisMusicNodes musicNodes: [SKNode]) -> () {
        
        for musicNode in musicNodes{
            
            let music = musicNode as! SKAudioNode
            music.run(SKAction.play())
            
            let distance = self.distanceBetween(thisNode: listnerNode, andThisNode: musicNode).x
            
            let minimumDistance = space.width / 12
            
            switch distance{
            case 0 ... minimumDistance:
                print("MAX")
                musicNode.run(SKAction.changeVolume(to: 0.6, duration: 0.5))
            case (minimumDistance + 1) ... (minimumDistance * 2):
                musicNode.run(SKAction.changeVolume(to: 0.25, duration: 0.5))
            default:
                musicNode.run(SKAction.changeVolume(to: 0, duration: 0.5))
            }
        }
        
    }
    
    static func distanceBetween(thisNode nodeA: SKNode, andThisNode nodeB: SKNode) -> CGPoint {
        return CGPoint(x: abs(nodeA.position.x - nodeB.position.x), y: abs(nodeA.position.y - nodeB.position.y))
    }

    
}
