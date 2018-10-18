//
//  DialogComponente.swift
//  Shyne
//
//  Created by Nickson Kley Gonçalves Da Silva on 17/10/2018.
//  Copyright © 2018 Abacate. All rights reserved.
//

import SpriteKit

class caixaDeDialogo{
    var Personagem: SKNode
    var Texto: String
    var cenario: SKNode
    
    init(personagem: SKNode, texto: String, cena: SKNode) {
        Personagem = personagem
        Texto = texto
        cenario = cena
    }
    
    func criar(){
        let caixaDialogo = SKSpriteNode(color: .white, size: CGSize(width: 100, height: 50))
        caixaDialogo.position = CGPoint(x: Personagem.position.x, y: Personagem.position.y)
        
        let textoDialogo = SKLabelNode(fontNamed: "Chalkduster")
        textoDialogo.text = Texto
        textoDialogo.fontSize = 50
        textoDialogo.fontColor = SKColor.green
        textoDialogo.position = CGPoint(x: 0, y: 0)
        caixaDialogo.addChild(textoDialogo)
        
        cenario.addChild(caixaDialogo)
        
        caixaDialogo.setScale(0)
        
        let moveDown = SKAction.moveBy(x: -100, y: 50, duration: 1)
        let scale = SKAction.scale(to: 1, duration: 1)
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        let group = SKAction.group([moveDown, scale, fadeIn])
        caixaDialogo.run(group)
    }
}
