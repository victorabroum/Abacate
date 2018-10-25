//
//  BakeryScene01.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 21/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit

class BakeryScene01: SKScene {
    
    var flag: Bool = false
    
    override func sceneDidLoad() {
        print("olaaaaaaaaaa")
    }
    
    override func update(_ currentTime: TimeInterval) {
//        print("foi")
        
        if !flag{
            if let gato = self.childNode(withName: "background") as? SKSpriteNode{
                print("UHUULLLL \(gato)")
            }
            flag = true
        }
    }

}
