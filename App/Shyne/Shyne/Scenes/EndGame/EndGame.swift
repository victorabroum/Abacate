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
        labelNode?.text = NSLocalizedString("SUAS ESCOLHAS\nTE TROUXERAM\nATÉ AQUI!", comment: "")
        
        labelNode?.run(SKAction.scale(by: 1.2, duration: 3.5)){
            self.labelNode?.alpha = 0
            self.backgroundNode?.texture = SKTexture(imageNamed: "Good_ending")
            self.goodEnd()
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
        annaNode.position = CGPoint(x: 23.506, y: -34.5)
        
        self.addChild(felipeNode)
        self.addChild(annaNode)
        
        // Eles levantam
        felipeNode.run(SKAction(named: "felipe_standUp")!) {
            // Ele andam
            let felipeWalk = SKAction(named: "playerWalk")!
            let goToPos = SKAction.moveTo(x: 228, duration: 2)
            let groupFelipe = SKAction.group([felipeWalk, goToPos])
            felipeNode.run(groupFelipe)
        }
        
        annaNode.run(SKAction(named: "anna_standUp")!) {
            annaNode.position.y = -57.615
            annaNode.size = CGSize(width: 108.7, height: 238)
            // Ela anda
            let annaWalk = SKAction(named: "anna_walk")!
            let goToPos = SKAction.moveTo(x: 228, duration: 1.5)
            let groupAnna = SKAction.group([annaWalk, goToPos])
            annaNode.run(groupAnna)
        }
        
        self.backgroundNode?.run(SKAction.wait(forDuration: 1)) {
            self.backgroundNode?.run(SKAction.fadeOut(withDuration: 2))
            annaNode.run(SKAction.fadeOut(withDuration: 2))
            felipeNode.run(SKAction.fadeOut(withDuration: 2))
            
            self.labelNode?.run(SKAction.fadeIn(withDuration: 1))
            self.labelNode?.text = NSLocalizedString("E NO DIA\nDA APRESENTAÇÃO\nESSE FOI O RESULTADO!", comment: "")
            self.labelNode?.run(SKAction.scale(by: 1.2, duration: 3.5)){
                self.labelNode?.alpha = 0
                self.backgroundNode?.texture = SKTexture(imageNamed: "Good_ending")
            }
        }
        
        
        
    }

}
