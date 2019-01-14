//
//  IdleState.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 22/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import GameplayKit
import SpriteKit

class IdleState: GKState {

    var nodeToIdle: PlayerNode
    
    init(withPlayerNode player: PlayerNode) {
        self.nodeToIdle = player
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is WalkingState.Type:
            // Pode ir pro walking state
            return true
        case is SitState.Type:
            return true
        case is PausedState.Type:
            return true
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        if (previousState as? WalkingState) != nil{
            self.nodeToIdle.entity?.removeComponent(ofType: Walkable.self)
        }
        
        let idle: PlayerIdle = PlayerIdle()
        idle.node = self.nodeToIdle
        idle.startIdle()
        self.nodeToIdle.entity?.addComponent(idle)
    }
    
}
