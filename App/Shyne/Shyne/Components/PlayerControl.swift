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
    
    @objc func swipedUp(_ sender:UISwipeGestureRecognizer){
        self.scene?.movePlayer(command: "up")
        print("swiped up")
    }
    
    @objc func swipedDown(_ sender:UISwipeGestureRecognizer){
        self.scene?.movePlayer(command: "down")
        print("swiped down")
    }
    
    func setupControllers(camera: SKCameraNode, scene: SKScene) -> () {
        touchControlNode = TouchController(frame: scene.frame)
        touchControlNode?.touchControlDelegate = self
        
        // Centralizando o node na scene
        touchControlNode?.position = CGPoint.zero
        
        // Add o node como filha do node camera
        camera.addChild(touchControlNode!)
        
        self.scene = scene as? GameScene
        
        // Swipe up
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp(_:)))
        swipeUp.direction = .up
        self.scene?.view?.addGestureRecognizer(swipeUp)
        
        // Swipe down
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown(_:)))
        swipeDown.direction = .down
        self.scene?.view?.addGestureRecognizer(swipeDown)
    }
    
    func follow(command: String?) {
        // Do something
        print("command \(command!)")
        
        // Move the player Node
        
        if self.scene != nil {
            self.scene?.movePlayer(command: command!)
        }
    }
    
}
