//
//  WalkingState.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 22/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import GameplayKit
import SpriteKit

class WalkingState: GKState {

    var nodeToWalk: PlayerNode
    
    init(withPlayerNode player: PlayerNode) {
        self.nodeToWalk = player
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is IdleState.Type:
            // Pode ir pro idle
            return true
        case is SitState.Type:
            return true
        default:
            return false
        }
    }
    
    override func didEnter(from previousState: GKState?) {
        if (previousState as? IdleState) != nil{
            self.nodeToWalk.entity?.removeComponent(ofType: Walkable.self)
            let walkComponent: Walkable = Walkable()
            walkComponent.node = self.nodeToWalk
            walkComponent.startWalk()
            self.nodeToWalk.entity?.addComponent(walkComponent)
        }
    }
    
}
