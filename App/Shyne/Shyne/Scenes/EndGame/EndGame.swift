//
//  EndGame.swift
//  Shyne
//
//  Created by Nickson Kley Gonçalves Da Silva on 31/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit

class EndGame: SKScene {

    override func sceneDidLoad() {
        
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
