//
//  PausedComponent.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 14/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class PausedComponent: GKComponent{
    var node = SKSpriteNode()
    
    func startPauseAnimation(){
        node.removeAllActions()
        node.run(SKAction(named: "pick_phone")!)
    }
    
    func exitPauseAnimate(){
        node.removeAllActions()
        let action = SKAction.init(named: "pick_phone")!
        node.run(action.reversed()){
            (self.node as! PlayerNode).actualDirection = .idle
            (self.node as! PlayerNode).enterIdleState()
        }
    }
}
