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
    
    static func updateMusicPan(forThisListner listnerNode: SKNode, fromThisMusicNodes musicNodes: [SKNode]) -> () {
        
        for musicNode in musicNodes{
            
            let distance = self.distanceBetween(thisNode: listnerNode, andThisNode: musicNode).x
            
            switch distance{
            case 0...500:
                musicNode.run(SKAction.changeVolume(to: 1.5, duration: 0.5))
            case 501...1000:
                musicNode.run(SKAction.changeVolume(to: 0.8, duration: 0.5))
            case 1001...:
                musicNode.run(SKAction.changeVolume(to: 0, duration: 0.5))
            default:
                break
            }
        }
        
    }
    
    static func distanceBetween(thisNode nodeA: SKNode, andThisNode nodeB: SKNode) -> CGPoint {
        return CGPoint(x: abs(nodeA.position.x - nodeB.position.x), y: abs(nodeA.position.y - nodeB.position.y))
    }

    
}
