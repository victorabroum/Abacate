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
    var isWalking: Bool = false
    var canWalk: Bool = true
    var cameraReference: SKSpriteNode = SKSpriteNode(texture: nil, color: UIColor.brown, size: CGSize(width: 50, height: 50))
    
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
    
    // Func to prepare camera and control
    func prepareControl(withCamera camera: SKCameraNode, inScene scene: SKScene) -> () {
        self.cameraReference.alpha = 0
        self.cameraReference.position.y += 225
        self.addChild(self.cameraReference)
        self.canWalk = true
        if let pcComponent = self.entity?.component(ofType: PlayerControl.self){
            pcComponent.setupControllers(camera: camera, scene: scene)
        }
    }
    
    // Player Can Walk?
    func playerCanWalk(_ flag: Bool) -> () {
        self.canWalk = flag
    }
    
    // Func to make player moves
    func makePlayerWalk(){
        
        if self.canWalk{
            if !self.isWalking {
                self.animateWalking()
            }
            
            switch self.actualDirection {
            case .right:
                if self.xScale <= 0{
                    self.xScale *= -1
                }
                self.position.x += playerVelocity
            case .left:
                if self.xScale >= 0{
                    self.xScale *= -1
                }
                self.position.x -= playerVelocity
            case .up:
                self.position.y += playerVelocity
            case .down:
                self.position.y -= playerVelocity
            default:
                // Idle
                self.isWalking = false
                break
            }
        }else{
            self.isWalking = false
        }
    }
    
    func animateWalking() -> (){
        self.isWalking = true
        let walkComponent: Walkable = Walkable()
        walkComponent.node = self
        walkComponent.startWalk()
    }

}
