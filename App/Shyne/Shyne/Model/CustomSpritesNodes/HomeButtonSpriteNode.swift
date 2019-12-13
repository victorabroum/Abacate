//
//  HomeButtonSpriteNode.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 08/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class HomeButtonSpriteNode: SKSpriteNode{
    
    init(imageNamed name: String){
        let texture = SKTexture(imageNamed: name)
        super.init(texture: texture, color: .clear
            , size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setup),
            name: CustomSKSCene.didMoveCompleteNotificationName,
            object: nil)
    }
    
    @objc func setup() {
        self.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.isUserInteractionEnabled = false
        
        if (self.entity != nil){
            for comp in (self.entity?.components)! {
                if let auxComp = comp as? ButtonComponent{
                    auxComp.action()
                }
            }
        }
        
    }
    
}

class StartHomeButtonNode: HomeButtonSpriteNode {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let entityHelper = GKEntity()
        entityHelper.addComponent(StartGameComponent())
        self.entity = entityHelper
        SKEntityManager.shared.add(entityHelper)
    }
}

class ContinueHomeButtonNode: HomeButtonSpriteNode {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let entityHelper = GKEntity()
        entityHelper.addComponent(ContinueGameComponent())
        self.entity = entityHelper
        SKEntityManager.shared.add(entityHelper)
    }
}
