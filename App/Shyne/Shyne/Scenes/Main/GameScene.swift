//
//  GameScene.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 17/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import SpriteKit
import GameplayKit

enum PlayerMovement {
    case right
    case left
    case idle
}

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    private var playerMovement: PlayerMovement = .idle
    private var playerNode: SKSpriteNode = SKSpriteNode()
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        self.playerNode = childNode(withName: "Player") as! SKSpriteNode
        
    }
    
    override func didMove(to view: SKView) {
        if let pcComponent = self.playerNode.entity?.component(ofType: PlayerControl.self){
            pcComponent.setupControllers(camera: camera!, scene: self)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        switch self.playerMovement {
        case .right:
            self.playerNode.position.x += playerVelocity
        case .left:
            self.playerNode.position.x -= playerVelocity
        default:
            // Idle
            break
        }
    }
    
    public func movePlayer(command: String) -> () {
        switch command {
        case "right":
            self.playerMovement = .right
        case "left":
            self.playerMovement = .left
        default:
            // Idle
            self.playerMovement = .idle
            break
        }
    }
    
}
