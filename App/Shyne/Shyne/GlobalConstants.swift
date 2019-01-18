//
//  GlobalConstants.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 17/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation
import SpriteKit

// Z Posiiton
var playerZPosition: CGFloat = 50
var zPositionToButton: CGFloat = 9999
let zPositionBallon: CGFloat = playerZPosition + 200
let zPositionBannerTutorial: CGFloat = zPositionBallon + 200
let zPositionImagePause: CGFloat = zPositionBallon + 200

// For The Player
var playerVelocity: CGFloat = 2.0


// Possibles direction for player moves
enum PlayerMovement {
    case right
    case left
    case idle
    case up
    case down
    case sit
    case paused
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

// Name of music for Background
struct BackgroundMusic {
    var name: String
    var musicExtension: String
    var volume: Float
    
    mutating func change(name:String, musicExtension : String = "wav", volume: Float){
        self.name = name
        self.musicExtension = musicExtension
        self.volume = volume
    }
}

var bgMusic = BackgroundMusic.init(name: "house", musicExtension: "wav", volume: 0.1)
let changeBGMusicNotificationName = Notification.Name("com.teamavocado.Hoody.changeBGMusicNotificationName")
