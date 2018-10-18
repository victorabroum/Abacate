//
//  GameScene.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 17/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
    }
    
    override func didMove(to view: SKView) {
        if let thePlayer = childNode(withName: "Player"){
            if let pcComponent = thePlayer.entity?.component(ofType: PlayerControl.self){
                pcComponent.setupControllers(camera: camera!, scene: self, playerNode: thePlayer as! SKSpriteNode)
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
