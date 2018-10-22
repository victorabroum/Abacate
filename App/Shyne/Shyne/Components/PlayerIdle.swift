//
//  PlayerIdle.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 22/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import GameplayKit
import SpriteKit

class PlayerIdle: GKComponent {

    var node = SKSpriteNode()
    
    func startIdle() -> () {
        node.removeAllActions()
        node.run(SKAction(named: "idle")!)
    }
    
}
