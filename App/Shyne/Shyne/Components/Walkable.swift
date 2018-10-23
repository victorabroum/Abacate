//
//  Walkable.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 17/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import GameplayKit
import SpriteKit

class Walkable: GKComponent {
    
    var node = SKSpriteNode()
    
    func startWalk(){
        node.run(SKAction(named: "playerWalk")!)
    }
}
