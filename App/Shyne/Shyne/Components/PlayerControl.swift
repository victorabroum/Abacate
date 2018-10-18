//
//  PlayerControl.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 17/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayerControl : GKComponent, TouchControlDelegate{
    
    let playerVelocity: CGFloat = 3.0
    var touchControlNode : TouchController?
    var playerNode: SKSpriteNode?
    
    func setupControllers(camera: SKCameraNode, scene: SKScene,
                          playerNode: SKSpriteNode) -> () {
        touchControlNode = TouchController(frame: scene.frame)
        touchControlNode?.touchControlDelegate = self
        
        // Centralizando o node na scene
        touchControlNode?.position = CGPoint.zero
        
        // Add o node como filha do node camera
        camera.addChild(touchControlNode!)
        
        // Iniciando o PlayerNode
        self.playerNode = playerNode
    }
    
    func follow(command: String?) {
        // Do something
        print("command \(command!)")
        
        // Move the player Node
        
        if self.playerNode != nil {
            switch command {
            case "rigth":
                // Move to right
                self.playerNode?.position.x -= self.playerVelocity
            case "left":
                // Move to left
                self.playerNode?.position.x += self.playerVelocity
            default:
                // Cancel move
                break
            }
        }
        
        
    }
    
    
}
