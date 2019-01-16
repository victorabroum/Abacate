//
//  PausedState.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 14/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class PausedState: GKState{
    var node: PlayerNode
    
    init(withPlayerNode player: PlayerNode) {
        self.node = player
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is IdleState.Type:
            return true
        case is WalkingState.Type:
            return true
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        if (previousState as? WalkingState) != nil{
            self.node.entity?.removeComponent(ofType: Walkable.self)
        }
        
        let animate = PausedComponent()
        animate.node = self.node
        animate.startPauseAnimation()
        self.node.entity?.addComponent(animate)
    }
}
