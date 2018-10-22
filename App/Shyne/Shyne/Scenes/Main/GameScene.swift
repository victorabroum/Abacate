//
//  GameScene.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 17/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    private var playerNode: PlayerNode?
    
    override func sceneDidLoad() {

        self.playerNode = childNode(withName: "playerNode") as? PlayerNode
        
        physicsWorld.contactDelegate = self
    }
    
    override func didMove(to view: SKView) {
        self.playerNode?.prepareControl(withCamera: camera!, inScene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.playerNode!.makePlayerWalk()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyB.node?.name!{
            lista[nome]?.funcaoEntrada()
        }
    }
    func didEnd(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyB.node?.name!{
            lista[nome]?.funcaoSaida()
        }
    }
}
