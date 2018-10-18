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
    var scene: GameScene?
    
    func setupControllers(camera: SKCameraNode, scene: SKScene) -> () {
        touchControlNode = TouchController(frame: scene.frame)
        touchControlNode?.touchControlDelegate = self
        
        // Centralizando o node na scene
        touchControlNode?.position = CGPoint.zero
        
        // Add o node como filha do node camera
        camera.addChild(touchControlNode!)
        
        self.scene = scene as? GameScene
    }
    
    func follow(command: String?) {
        // Do something
        print("command \(command!)")
        
        // Move the player Node
        
        if self.scene != nil {
            self.scene?.movePlayer(command: command!)
//            switch command {
//            case "right":
//                // Move to right
//
//                break
//            case "left":
//                // Move to left
//                break
//            default:
//                // Cancel move
//                break
//            }
        }
        
        
    }
    
    
}
