//
//  SitComponent.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 11/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class SitComponent: GKComponent {
    
    var node = SKSpriteNode()
    
    func startIdle(){
        node.removeAllActions()
        node.run(SKAction(named: "sitIdle")!)
    }
    
}
