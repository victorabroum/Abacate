//
//  SitState.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 11/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit


class SitState: GKState {
    
    var nodeToIdle: PlayerNode
    
    init(withPlayerNode player: PlayerNode) {
        self.nodeToIdle = player
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is WalkingState.Type:
            // Pode ir pro walking state
            return true
        case is IdleState.Type:
            return true
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        if (previousState as? WalkingState) != nil{
            self.nodeToIdle.entity?.removeComponent(ofType: Walkable.self)
        }
        
        let idle = SitComponent()
        idle.node = self.nodeToIdle
        idle.startIdle()
        self.nodeToIdle.entity?.addComponent(idle)
    }
    
}
