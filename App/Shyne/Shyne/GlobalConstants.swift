//
//  GlobalConstants.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 17/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation
import SpriteKit

var zPositionToButton: CGFloat = 10

// For The Player
var playerVelocity: CGFloat = 10.0

// Possibles direction for player moves
enum PlayerMovement {
    case right
    case left
    case idle
    case up
    case down
}
