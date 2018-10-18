//
//  DialogComponente.swift
//  Shyne
//
//  Created by Nickson Kley Gonçalves Da Silva on 17/10/2018.
//  Copyright © 2018 Abacate. All rights reserved.
//

import SpriteKit

class caixaDeDialogo: SKSpriteNode{
    var Personagem: SKNode
    var Texto: String
    
    init(personagem: SKNode, texto: String) {
        Personagem = personagem
        Texto = texto
        
        super.init(texture: nil, color: .white, size: CGSize(width: 100, height: 50))
        self.setScale(1)
        let text = SKLabelNode(text: texto)
        text.fontName = "Chalkduster"
        text.position = CGPoint(x: 0, y: 0)
        text.fontColor = .black
        self.addChild(text)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func entrar(){
        let moveDown = SKAction.moveBy(x: -100, y: 50, duration: 1)
        let scale = SKAction.scale(to: 1, duration: 1)
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        let group = SKAction.group([moveDown, scale, fadeIn])
        self.run(group)
    }
    
    func sair() {
        let scale = SKAction.scale(to: 0, duration: 0.3)
        let fadeIn = SKAction.fadeIn(withDuration: 0.3)
        let group = SKAction.group([scale, fadeIn])
        self.run(group)
    }
}
