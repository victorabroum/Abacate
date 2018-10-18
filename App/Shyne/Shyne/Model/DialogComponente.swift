//
//  DialogComponente.swift
//  Shyne
//
//  Created by Nickson Kley Gonçalves Da Silva on 17/10/2018.
//  Copyright © 2018 Abacate. All rights reserved.
//

import SpriteKit

enum sideView{
    case left
    case rigth
}

class caixaDeDialogo: SKSpriteNode{
    var Personagem: SKNode
    var Texto: String
    var Direcao: sideView
    var animado: Bool
    
    init(personagem: SKNode, texto: String, direcao: sideView) {
        Personagem = personagem
        Texto = texto
        Direcao = direcao
        animado = false
        
        super.init(texture: nil, color: .white, size: CGSize(width: 100, height: 50))
        self.setScale(1)
        self.zPosition = 100
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
        if(!animado){
            animado = true
            
            let caminho: SKAction
            switch Direcao {
            case .left:
                caminho = SKAction.moveBy(x: 100,y: 100, duration: 0.3)
            case .rigth:
                caminho = SKAction.moveBy(x: -100, y: 100, duration: 0.3)
            }
            self.position = CGPoint(x: Personagem.position.x, y: Personagem.position.y)
            let moveDown = caminho
            let scale = SKAction.scale(to: 1, duration: 0.3)
            let fadeIn = SKAction.fadeIn(withDuration: 0.3)
            
            let group = SKAction.sequence( [SKAction.group([moveDown, scale, fadeIn])])
            self.run(group){
                self.animado = false
            }
        }
    }
    
    func entra(ponto: CGPoint){
        if(!animado){
            animado = true
            print("teste")
            self.position = CGPoint(x: Personagem.position.x, y: Personagem.position.y)
            let moveDown = SKAction.move(to: ponto, duration: 0.3)
            let scale = SKAction.scale(to: 1, duration: 0.3)
            let fadeIn = SKAction.fadeIn(withDuration: 0.3)
            
            let group = SKAction.sequence( [SKAction.group([moveDown, scale, fadeIn])])
            self.run(group){
                self.animado = false
            }
        }
    }
    
    func sair() {
        if(!animado){
            animado = true
            let scale = SKAction.scale(to: 0, duration: 0.1)
            let fadeIn = SKAction.fadeIn(withDuration: 0.1)
            let group = SKAction.group([scale, fadeIn])
            self.run(group){
                self.animado = false
            }
        }
        
    }

}
