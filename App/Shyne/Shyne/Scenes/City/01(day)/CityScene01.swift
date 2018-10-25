//
//  CityScene01.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 21/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class CityScene01: SKScene {
    
    var playerNode: PlayerNode?
    
    var entities = [GKEntity]()
    
    override func sceneDidLoad() {
        self.playerNode = self.childNode(withName: "playerNode") as? PlayerNode
    }
    
    override func didMove(to view: SKView) {
        self.playerNode?.prepareControl(withCamera: camera!, inScene: self, withCameraOffset: 135)
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.playerNode?.makePlayerWalk()
    }

}
