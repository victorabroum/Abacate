//
//  HomeButtonSpriteNode.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 08/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation
import SpriteKit

class HomeButtonSpriteNode: SKSpriteNode{
    
    init(imageNamed name: String){
        let texture = SKTexture(imageNamed: name)
        super.init(texture: texture, color: .clear
            , size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("name \(self.name ?? "Não tem nome")")
        NotificationCenter.default.addObserver(self, selector: #selector(setup), name: CustomSKSCene.didMoveCompleteNotificationName, object: nil)
        
    }
    
    @objc func setup() {
        
        self.isUserInteractionEnabled = true
        
//        if(self.entity != nil){
//            let text = self.userData?.value(forKey: "text")
//            self.entity?.addComponent(ButtonLayoutComponent(withText: "\(text ?? "NO NAME")", onNode: self))
//        }
//        
//        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (self.entity != nil){
            for comp in (self.entity?.components)! {
                if let auxComp = comp as? ButtonComponent{
                    auxComp.action()
                }
            }
        }
        
    }
    
}
