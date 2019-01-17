//
//  PauseButtonNode.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 14/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation
import SpriteKit

class ActionSpriteNode: SKSpriteNode{
    
    var action: (()->Void)?
    
    required init?(coder aDecoder: NSCoder) {
        action = nil
        super.init(coder: aDecoder)
        
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        action = nil
        super.init(texture: texture, color: color, size: size)
        
    }
    
    init(imageNamed name: String, action:(()->Void)? = nil){
        let texture = SKTexture(imageNamed: name)
        self.action = action
        super.init(texture: texture, color: .clear, size: texture.size())
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Resposta háptica
        let notification = UISelectionFeedbackGenerator()
        notification.selectionChanged()
        
        if(action != nil){
            action!()
        }
    }
}
