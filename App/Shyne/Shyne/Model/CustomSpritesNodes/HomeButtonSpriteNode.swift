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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("name \(self.name ?? "Não tem nome")")
        self.texture = SKTexture(imageNamed: "dialogue_box_dir")
        NotificationCenter.default.addObserver(self, selector: #selector(setup), name: CustomSKSCene.didLoadCompleteNotificationName, object: nil)
        
    }
    
    @objc func setup() {
        
        self.isUserInteractionEnabled = true
        
//        // Setup label
//        let text = self.userData?.value(forKey: "text")
//        let labelNode = SKLabelNode(text: "\(text ?? "NO TEXT")")
//        labelNode.fontSize = 22
//        labelNode.fontName = "Futura"
//        labelNode.position = CGPoint.zero
//        labelNode.horizontalAlignmentMode = .center
//        labelNode.verticalAlignmentMode = .center
//        labelNode.fontColor = .black
//        labelNode.zPosition = self.zPosition + 50
//        self.addChild(labelNode)
//
//        // Ajust ballon size
//        self.size.width = (1.5 * labelNode.frame.size.width)
        
        if(self.entity != nil){
            let text = self.userData?.value(forKey: "text")
            self.entity?.addComponent(ButtonLayoutComponent(withText: "\(text ?? "NO NAME")", onNode: self))
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("CLICOU EM \(self.name ?? "NO NAME")")
        
        if (self.entity != nil){
            for comp in (self.entity?.components)! {
                if let auxComp = comp as? ButtonComponent{
                    auxComp.action()
                }
            }
        }
        
    }
    
}
