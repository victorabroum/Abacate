//
//  PlayerNode.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 22/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit

class PlayerNode: SKSpriteNode {
    
    var actualDirection: PlayerMovement = .idle
    
    public func movePlayer(command: String) -> () {
        switch command {
        case "right":
            self.actualDirection = .right
        case "left":
            self.actualDirection = .left
        case "up":
            self.actualDirection = .up
        case "down":
            self.actualDirection = .down
        default:
            // Idle
            self.actualDirection = .idle
            break
        }
    }
    
    public func getActualDirection() -> PlayerMovement{
        return self.actualDirection
    }
    
    // Func to make player moves
    func makePlayerWalk(){
        
        switch self.actualDirection {
        case .right:
            self.position.x += playerVelocity
        case .left:
            self.position.x -= playerVelocity
        case .up:
            self.position.y += playerVelocity
        case .down:
            self.position.y -= playerVelocity
        default:
            break
        }
    }

}
