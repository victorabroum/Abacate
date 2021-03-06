//
//  PlayerNode.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 22/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class PlayerNode: SKSpriteNode{
    
    var actualDirection: PlayerMovement = .idle
    var isWalking: Bool = false
    var canWalk: Bool = true
    var cameraReference: SKSpriteNode = SKSpriteNode(texture: nil, color: UIColor.brown, size: CGSize(width: 50, height: 50))
    var stateMachine: GKStateMachine?
    
    func prepareStateMachine(){
        self.stateMachine = GKStateMachine(states: [IdleState(withPlayerNode: self),
                                                    WalkingState(withPlayerNode: self)])
    }
    
    func enterIdleState(){
        if self.stateMachine != nil{
            self.stateMachine?.enter(IdleState.self)
        }
    }
    
    func enterWalkingState(){
        if self.stateMachine != nil{
            self.stateMachine?.enter(WalkingState.self)
        }
    }
    
    
    public func movePlayer(command: String){
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
    func prepareControl(withCamera camera: SKCameraNode, inScene scene: SKScene, withCameraOffset cameraOffset: CGFloat){
        
        self.zPosition = playerZPosition
        self.texture?.filteringMode = .linear
        
        self.isUserInteractionEnabled = false
        
        // Add camera reference to follow
        self.cameraReference.alpha = 0
        self.cameraReference.position.y += cameraOffset
        self.addChild(self.cameraReference)
        
        // Setup statemachine
        self.prepareStateMachine()
        // Began in idle state
        self.enterIdleState()
        
        // Said player really can walk
        self.canWalk = true
        
        // Setup component controllers
        
        if let pcComponent = self.entity?.component(ofType: PlayerControl.self){
            pcComponent.setupControllers(camera: camera, scene: scene, withOffset: cameraOffset)
        }
    }
    
    // Player Can Walk?
    func playerCanWalk(_ flag: Bool){
        self.canWalk = flag
        if !flag {
            self.enterIdleState()
        }
    }
    
    // Func to make player moves
    func makePlayerWalk(){
        
        if self.canWalk{
            
            switch self.actualDirection {
            case .right:
                if self.xScale <= 0{
                    self.xScale *= -1
                }
                self.position.x += playerVelocity
                self.enterWalkingState()
            case .left:
                if self.xScale >= 0{
                    self.xScale *= -1
                }
                self.position.x -= playerVelocity
                self.enterWalkingState()
            default:
                // Idle
                self.isWalking = false
                self.enterIdleState()
            }
        }else{
            self.enterIdleState()
        }
    }
    
    func makeMove(fromPosition from: CGPoint, toPosition pos: CGPoint, withDuration duration: TimeInterval){
//        self.anchorPoint = CGPoint(x: 0.5, y: 0)
        self.playerCanWalk(false)
        self.position = from
        let backupSize = self.size
        self.size = CGSize(width: 48.48, height: 144)
        
        var arrayTexture = [SKTexture]()
        
        for index in 1 ..< 10 {
            let textureNamed = SKTexture(imageNamed: "upstairs_player_0\(index)")
            print("NAMED \(textureNamed)")
            arrayTexture.append(textureNamed)
        }
        
        let moveAction = SKAction.move(to: pos, duration: duration)
        let animateAction = SKAction(named: "stairs")
        let group = SKAction.group([moveAction, animateAction!])
        
        self.run(group, completion: {
            self.size = backupSize
            self.texture = SKTexture(imageNamed: "walk_player_01")
            self.playerCanWalk(true)
        })
        print("self size \(self.size)")
        print("self size \(backupSize)")
    }

}
