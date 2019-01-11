//
//  EndGame.swift
//  Shyne
//
//  Created by Nickson Kley Gonçalves Da Silva on 31/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit

class EndGame: SKScene {

    var labelNode: SKLabelNode?
    var backgroundNode: SKSpriteNode?
    
    override func sceneDidLoad() {
        
        
        if let node = self.childNode(withName: "text") as? SKLabelNode {
            print("TEXT")
            labelNode = node
        }
        
        if let back = self.childNode(withName: "background") as? SKSpriteNode{
            backgroundNode = back
        }
        
        labelNode?.horizontalAlignmentMode = .center
        labelNode?.verticalAlignmentMode = .center
        labelNode?.text = NSLocalizedString("SUAS ESCOLHAS\n TE TROUXERAM\n      ATÉ AQUI!", comment: "")
        
        labelNode?.run(SKAction.scale(by: 1.2, duration: 3.5)){
            self.labelNode?.alpha = 0
            self.backgroundNode?.texture = SKTexture(imageNamed: "Good_ending")
//            self.goodEnd()
            self.mediumEnd()
        }
        
        
        
//        if( happyStatus>normalStatus && happyStatus>shyStatus ){
//            back.texture = SKTexture(imageNamed: "final_bom")
//        }
//        else if( normalStatus>happyStatus && normalStatus>shyStatus ){
//            back.texture = SKTexture(imageNamed: "final_medio")
//        }
//        else{
//            back.texture = SKTexture(imageNamed: "final_ruim")
//        }
    }
    
    func goodEnd() {
        
        let felipeNode = SKSpriteNode(texture: SKTexture(imageNamed: "standing_01"), color: .clear
            , size: CGSize(width: 138.28, height: 248))
        felipeNode.position = CGPoint(x: -94.365, y: -49.329)
        
        let annaNode = SKSpriteNode(texture: SKTexture(imageNamed: "anna_standing_01"), color: .clear
            , size: CGSize(width: 155.27, height: 285))
        annaNode.xScale = 0.9
        annaNode.yScale = 0.9
        annaNode.position = CGPoint(x: 17.969, y: -48.329)
        
        self.addChild(felipeNode)
        self.addChild(annaNode)
        
        // Eles levantam
        felipeNode.run(SKAction(named: "felipe_standUp")!) {
            // Ele andam
            felipeNode.position = CGPoint(x: -72.422, y: -49.422)
            let felipeWalk = SKAction(named: "playerWalk")!
            let goToPos = SKAction.moveTo(x: 228, duration: 2)
            let groupFelipe = SKAction.group([felipeWalk, goToPos])
            felipeNode.run(groupFelipe)
        }
        
        annaNode.run(SKAction(named: "anna_standUp")!) {
            annaNode.position = CGPoint(x: 54.35, y: -57.579)
            annaNode.size = CGSize(width: 108.7, height: 238)
            // Ela anda
            let annaWalk = SKAction(named: "anna_walk")!
            let goToPos = SKAction.moveTo(x: 228, duration: 1.5)
            let groupAnna = SKAction.group([annaWalk, goToPos])
            annaNode.run(groupAnna)
        }
        
        self.backgroundNode?.run(SKAction.wait(forDuration: 2)) {
            
            self.backgroundNode?.run(SKAction.fadeOut(withDuration: 2))
            annaNode.run(SKAction.fadeOut(withDuration: 1.5))
            felipeNode.run(SKAction.fadeOut(withDuration: 1.5))

            self.labelNode?.xScale = 1
            self.labelNode?.yScale = 1
            
            self.labelNode?.run(SKAction.wait(forDuration: 2)){
                self.labelNode?.run(SKAction.fadeIn(withDuration: 1))
                self.labelNode?.text = NSLocalizedString("E NO DIA\nDA APRESENTAÇÃO\nESSE FOI O RESULTADO!", comment: "")
                self.labelNode?.run(SKAction.scale(by: 1.2, duration: 3.5)){
                    self.labelNode?.alpha = 0
                    
                    self.backgroundNode?.alpha = 1
                    
                    
                    // Ajeita os Node
                    felipeNode.alpha = 1
                    felipeNode.position = CGPoint(x: 174.518, y: -50.422)
                    felipeNode.size = CGSize(width: 82, height: 246)
                    
                    annaNode.alpha = 1
                    annaNode.xScale = -1
                    annaNode.yScale = 1
                    annaNode.size = CGSize(width: 57.92, height: 236)
                    annaNode.position = CGPoint(x: 275, y: -56.579)
                    
                    // Remove walk animation
                    felipeNode.removeAllActions()
                    annaNode.removeAllActions()
                    
                    // Felipe apresenta
                    felipeNode.run(SKAction(named: "felipe_presentation")!)
                    // Anna fica no idle
                    annaNode.run(SKAction(named: "anna_idle")!)
                    
                    // Botando o balao de fala
                    let ballonNode = SKSpriteNode(imageNamed: "balao_fala")
                    ballonNode.xScale = 0.7
                    ballonNode.yScale = 0.7
                    ballonNode.position = CGPoint(x: 121.5, y: 30.686)
                    let goUp = SKAction.moveBy(x: 5, y: 5, duration: 0.5)
                    let goDown = SKAction.moveBy(x: -5, y: -5, duration: 0.5)
                    let sequenceBallon = SKAction.sequence([goUp, goDown])
                    ballonNode.run(SKAction.repeatForever(sequenceBallon))
                    
                    self.addChild(ballonNode)
                    
                    // Botando alunos
                    let greenGuy = SKSpriteNode(imageNamed: "good_green_01")
                    greenGuy.size = CGSize(width: 155.27, height: 285)
                    greenGuy.position = CGPoint(x: 14.559, y: -62.922)
                    greenGuy.run(SKAction(named: "greenGuy_clap")!)
                    
                    self.addChild(greenGuy)
                    
                    let redGuy = SKSpriteNode(imageNamed: "good_red_01")
                    redGuy.size = CGSize(width: 155.27, height: 285)
                    redGuy.position = CGPoint(x: -115.135, y: -61.922)
                    redGuy.run(SKAction(named: "redGuy_clap")!)
                    self.addChild(redGuy)
                    
                    // Botando o clap
                    let clapNode = SKSpriteNode(imageNamed: "clap")
                    clapNode.position = CGPoint(x: 31, y: 1)
                    clapNode.run(SKAction.repeatForever(sequenceBallon))
                    self.addChild(clapNode)
                    
                    let clapNodeB = SKSpriteNode(imageNamed: "clap")
                    clapNodeB.position = CGPoint(x: -80, y: 1)
                    clapNodeB.run(SKAction.repeatForever(sequenceBallon))
                    self.addChild(clapNodeB)
                    
                    let clapNodeC = SKSpriteNode(imageNamed: "clap")
                    clapNodeC.position = CGPoint(x: -229, y: 83.578)
                    clapNodeC.run(SKAction.repeatForever(sequenceBallon))
                    self.addChild(clapNodeC)
                    
                    self.backgroundNode?.run(SKAction.wait(forDuration: 5)){
                        
                        self.backgroundNode?.run(SKAction.fadeOut(withDuration: 2))
                        
                        annaNode.run(SKAction.fadeOut(withDuration: 1.5))
                        felipeNode.run(SKAction.fadeOut(withDuration: 1.5))
                        clapNode.run(SKAction.fadeOut(withDuration: 1.5))
                        clapNodeB.run(SKAction.fadeOut(withDuration: 1.5))
                        clapNodeC.run(SKAction.fadeOut(withDuration: 1.5))
                        ballonNode.run(SKAction.fadeOut(withDuration: 1.5))
                        redGuy.run(SKAction.fadeOut(withDuration: 1.5))
                        greenGuy.run(SKAction.fadeOut(withDuration: 1.5))
                        
                        self.labelNode?.xScale = 1
                        self.labelNode?.yScale = 1
                        
                        self.labelNode?.run(SKAction.wait(forDuration: 2)){
                            self.labelNode?.run(SKAction.fadeIn(withDuration: 1))
                            self.labelNode?.text = NSLocalizedString("TEXTO GENÉRICO\nQUE FALTA", comment: "")
                            self.labelNode?.run(SKAction.scale(by: 1.2, duration: 3.5))
                        }
                    }
                    
                }
            }
        }
    }
    
    func mediumEnd(){
        
        
        let felipeNode = SKSpriteNode(texture: SKTexture(imageNamed: "standing_01"), color: .clear
            , size: CGSize(width: 138.28, height: 248))
        felipeNode.position = CGPoint(x: -94.365, y: -49.329)
        
        let annaNode = SKSpriteNode(texture: SKTexture(imageNamed: "anna_standing_01"), color: .clear
            , size: CGSize(width: 155.27, height: 285))
        annaNode.xScale = 0.9
        annaNode.yScale = 0.9
        annaNode.position = CGPoint(x: 17.969, y: -48.329)
        
        self.addChild(felipeNode)
        self.addChild(annaNode)
        
        // Eles levantam
        felipeNode.run(SKAction(named: "felipe_standUp")!) {
            // Ele andam
            felipeNode.position = CGPoint(x: -72.422, y: -49.422)
            let felipeWalk = SKAction(named: "playerWalk")!
            let goToPos = SKAction.moveTo(x: 228, duration: 2)
            let groupFelipe = SKAction.group([felipeWalk, goToPos])
            felipeNode.run(groupFelipe)
        }
        
        annaNode.run(SKAction(named: "anna_standUp")!) {
            annaNode.position = CGPoint(x: 54.35, y: -57.579)
            annaNode.size = CGSize(width: 108.7, height: 238)
            // Ela anda
            let annaWalk = SKAction(named: "anna_walk")!
            let goToPos = SKAction.moveTo(x: 228, duration: 1.5)
            let groupAnna = SKAction.group([annaWalk, goToPos])
            annaNode.run(groupAnna)
        }
        
        
        self.backgroundNode?.run(SKAction.wait(forDuration: 2)) {
            
            self.backgroundNode?.run(SKAction.fadeOut(withDuration: 2))
            annaNode.run(SKAction.fadeOut(withDuration: 1.5))
            felipeNode.run(SKAction.fadeOut(withDuration: 1.5))
            
            self.labelNode?.xScale = 1
            self.labelNode?.yScale = 1
            
            self.labelNode?.run(SKAction.wait(forDuration: 2)){
                self.labelNode?.run(SKAction.fadeIn(withDuration: 1))
                self.labelNode?.text = NSLocalizedString("            E NO DIA\n     DA APRESENTAÇÃO\nESSE FOI O RESULTADO!", comment: "")
                self.labelNode?.run(SKAction.scale(by: 1.2, duration: 3.5)){
                    self.labelNode?.alpha = 0
                    
                    self.backgroundNode?.alpha = 1
                    
                    
                    // Ajeita os Node
                    felipeNode.alpha = 1
                    felipeNode.xScale *= -1
                    felipeNode.position = CGPoint(x: 267.755, y: -50.422)
                    
                    annaNode.alpha = 1
                    annaNode.xScale = 1
                    annaNode.yScale = 1
                    annaNode.size = CGSize(width: 82, height: 246)
                    annaNode.position = CGPoint(x: 169.32, y: -56.364)
                    
                    // Remove walk animation
                    felipeNode.removeAllActions()
                    annaNode.removeAllActions()
                    
                    // Anna apresenta
                    annaNode.run(SKAction(named: "anna_presentation")!)
                    // Felipe fica no idle
                    felipeNode.run(SKAction(named: "idle")!)
                    
                    // Botando o balao de fala
                    let ballonNode = SKSpriteNode(imageNamed: "balao_fala")
                    ballonNode.xScale = 0.7
                    ballonNode.yScale = 0.7
                    ballonNode.position = CGPoint(x: 105, y: 30.686)
                    let goUp = SKAction.moveBy(x: 5, y: 5, duration: 0.5)
                    let goDown = SKAction.moveBy(x: -5, y: -5, duration: 0.5)
                    let sequenceBallon = SKAction.sequence([goUp, goDown])
                    ballonNode.run(SKAction.repeatForever(sequenceBallon))
                    
                    self.addChild(ballonNode)
                    
                    // Botando alunos
                    let greenGuy = SKSpriteNode(imageNamed: "medium_green_01")
                    greenGuy.xScale = 0.5
                    greenGuy.yScale = 0.5
                    greenGuy.position = CGPoint(x: 14.559, y: -62.922)
                    greenGuy.run(SKAction(named: "greenGuy_sleep")!)
                    
                    self.addChild(greenGuy)
                    
                    let redGuy = SKSpriteNode(imageNamed: "medium_red_01")
                    redGuy.xScale = 0.5
                    redGuy.yScale = 0.5
                    redGuy.position = CGPoint(x: -115.135, y: -61.922)
                    redGuy.run(SKAction(named: "redGuy_smartphone")!)
                    self.addChild(redGuy)
                    
                    // Add Zzz
                    let zzzNode = SKSpriteNode(imageNamed: "zzz")
                    zzzNode.position = CGPoint(x: 16, y: 59)
                    zzzNode.run(SKAction.repeatForever(sequenceBallon))
                    self.addChild(zzzNode)
                    
                    self.backgroundNode?.run(SKAction.wait(forDuration: 5)){
                        
                        self.backgroundNode?.run(SKAction.fadeOut(withDuration: 2))
                        
                        annaNode.run(SKAction.fadeOut(withDuration: 1.5))
                        felipeNode.run(SKAction.fadeOut(withDuration: 1.5))
                        ballonNode.run(SKAction.fadeOut(withDuration: 1.5))
                        redGuy.run(SKAction.fadeOut(withDuration: 1.5))
                        greenGuy.run(SKAction.fadeOut(withDuration: 1.5))
                        zzzNode.run(SKAction.fadeOut(withDuration: 1.5))
                        
                        self.labelNode?.xScale = 1
                        self.labelNode?.yScale = 1
                        
                        self.labelNode?.run(SKAction.wait(forDuration: 2)){
                            self.labelNode?.run(SKAction.fadeIn(withDuration: 1))
                            self.labelNode?.text = NSLocalizedString("TEXTO GENÉRICO\nQUE FALTA", comment: "")
                            self.labelNode?.run(SKAction.scale(by: 1.2, duration: 3.5))
                        }
                    }
                    
                }
            }
        }
        
    }

}
