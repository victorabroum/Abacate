//
//  GlobalConstants.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 17/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation
import SpriteKit

var zPositionToButton: CGFloat = 50

// For The Player
var playerVelocity: CGFloat = 4.0
var playerZPosition: CGFloat = 450

// Possibles direction for player moves
enum PlayerMovement {
    case right
    case left
    case idle
    case up
    case down
}

// Status of choices
var happyStatus: Float = 0.0
var normalStatus: Float = 0.0
var shyStatus: Float = 0.0

// Flags important para o game
var finishedBakery: Bool = false
