//
//  DialogeActionsHelper.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 31/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation
import SpriteKit

class DialogeActionHelper {
    
    static func closedDoor(inNode node: SKNode, withDialoge dialoge: Dialogavel, usingTexture texture: String) {
        dialoge.caixa = caixaDeEscada(personagem: node, dialogavel: dialoge, texture: texture, function: {
            
            
            
        })
    }
}
