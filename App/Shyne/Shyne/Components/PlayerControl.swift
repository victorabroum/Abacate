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
    
    var touchControlNode : TouchController?
    var scene: GameScene?
    var playerNode: PlayerNode?
    
    @objc func swipedUp(_ sender:UISwipeGestureRecognizer){
//        self.scene?.movePlayer(command: "up")
        self.playerNode?.movePlayer(command: "up")
        print("swiped up")
    }
    
    @objc func swipedDown(_ sender:UISwipeGestureRecognizer){
//        self.scene?.movePlayer(command: "down")
        self.playerNode?.movePlayer(command: "down")
        print("swiped down")
    }
    
    func setupControllers(camera: SKCameraNode, scene: SKScene) -> () {
        touchControlNode = TouchController(frame: scene.frame)
        touchControlNode?.touchControlDelegate = self
        
        // Centralizando o node na scene
        touchControlNode?.position = CGPoint.zero
        
        // Add o node como filha do node camera
        camera.addChild(touchControlNode!)
        
        // Get reference of Game Scene
        self.scene = scene as? GameScene
        
        playerNode = self.scene?.childNode(withName: "playerNode") as? PlayerNode
        
        // Set swipe controller
        self.setSwiperController()
        
        // Set camera constraints
        if self.playerNode != nil{
            print("Tem player")
            self.set(cameraConstraints: camera, onplayerNode: self.playerNode!.cameraReference)
        }
        
        
    }
    
    func follow(command: String?) {
        // Do something
//        print("command \(command!)")
        
        if self.scene != nil {
//            self.scene?.movePlayer(command: command!)
            self.playerNode?.movePlayer(command: command!)
        }
    }
    
    func setSwiperController() -> () {
        // Swipe up
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp(_:)))
        swipeUp.direction = .up
        self.scene?.view?.addGestureRecognizer(swipeUp)
        
        // Swipe down
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown(_:)))
        swipeDown.direction = .down
        self.scene?.view?.addGestureRecognizer(swipeDown)
    }
    
    func set(cameraConstraints camera: SKCameraNode, onplayerNode player: SKSpriteNode) -> () {
        let zeroRange = SKRange(constantValue: 0)
        let playerBotLocationConstraint = SKConstraint.distance(zeroRange, to: player)

//        // get the frame of the entire level contents
        let boardNode:SKSpriteNode = scene?.childNode(withName: "background")! as! SKSpriteNode
        let bounds: CGFloat = (boardNode.size.width / 2) - (boardNode.size.width / 5) + 550
        let middleRange = SKRange(lowerLimit: -bounds, upperLimit: bounds)
        let levelEdgeConstraint = SKConstraint.distance(middleRange, to: boardNode)

        camera.constraints = [playerBotLocationConstraint, levelEdgeConstraint]
    }
    
    // Caso precise remover as constrains da camera seguir o player
    func removeConstrainsts(ofCamera camera: SKCameraNode) -> () {
        camera.constraints = []
    }
    
}
