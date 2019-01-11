//
//  GlobalConstants.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 17/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation
import SpriteKit

var zPositionToButton: CGFloat = 150

// For The Player
var playerVelocity: CGFloat = 2.5
var playerZPosition: CGFloat = 50

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
var normalStatus: Float = 10.0
var shyStatus: Float = 0.0

// Camera pos in house
var cameraDown: CGFloat = -100
var cameraUpper: CGFloat = 100

// Stairs animation duration
var stairDuration: TimeInterval = 2


var escolhaFeita = 1
var falouComPaiNaCasa01 = false
var roupaNaoEscolhida = true
var indoParaPadaria = true

var listaPermissoesHouse01:Set = ["goDown","goUp","triggerDad", "dadDoor"]
var listaPermissoesCidade:Set = ["bakeryDoor"]
var listaPermissoesPadaria:Set = ["padeiro"]
var listaPermissoesHouse02:Set = ["goDown","goUp","dady", "dadDoor"]
var listaPermissoesHouse03:Set = ["goDown","goUp","triggerDad", "dadDoor"]
var listaPermissoesRoom02:Set = ["cama"]
