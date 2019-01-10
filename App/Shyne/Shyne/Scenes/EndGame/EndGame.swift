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
    
    override func sceneDidLoad() {
        
        
        if let node = self.childNode(withName: "text") as? SKLabelNode {
            labelNode = node
            labelNode?.text = NSLocalizedString("SUAS ESCOLHAS TE TROUXERAM ATÉ AQUI!", comment: "")
        }
        
        let back = self.childNode(withName: "background") as! SKSpriteNode
        if( happyStatus>normalStatus && happyStatus>shyStatus ){
            back.texture = SKTexture(imageNamed: "final_bom")
        }
        else if( normalStatus>happyStatus && normalStatus>shyStatus ){
            back.texture = SKTexture(imageNamed: "final_medio")
        }
        else{
            back.texture = SKTexture(imageNamed: "final_ruim")
        }
    }

}
