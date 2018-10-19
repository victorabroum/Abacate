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

class Balao: SKSpriteNode{
    init(direcao: sideView, texto: String) {
        super.init(texture: nil, color: .white, size: CGSize(width: 100, height: 50))
        self.setScale(0)
        
        let text = SKLabelNode(text: texto)
        text.fontName = "Chalkduster"
        text.position = CGPoint(x: 0, y: 0)
        text.fontColor = .black
        self.addChild(text)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            
        }
    }
}

class baloesDeEscolha{
    var animado1 = false
    var animado2 = false
    var animado3 = false
    let balao1 : Balao
    let balao2 : Balao
    let balao3 : Balao
    let Personagem : SKSpriteNode
    let Direcao : sideView
    let Respostas : [Answer]
    
    init(personagem: SKSpriteNode, direcao: sideView, respostas:[Answer]) {
        Personagem = personagem
        Direcao = direcao
        Respostas = respostas
        
        balao1 = Balao(direcao: direcao, texto: Respostas[0].text)
        balao2 = Balao(direcao: direcao, texto: Respostas[1].text)
        balao3 = Balao(direcao: direcao, texto: Respostas[2].text)
        balao1.position = CGPoint(x: personagem.position.x-150, y: personagem.position.y)
        balao2.position = CGPoint(x: personagem.position.x-150, y: personagem.position.y + 100)
        balao3.position = CGPoint(x: personagem.position.x, y: personagem.position.y+100)
    }
    
    func desenhar(){
        
        Personagem.addChild(balao1);
        
        if(!animado1){
            animado1 = true
            let scale = SKAction.scale(to: 1, duration: 1)
            let fadeIn = SKAction.fadeIn(withDuration: 1)
            
            let group = SKAction.sequence( [SKAction.group([scale, fadeIn])])
            balao1.run(group){
                self.animado1 = false
            }
        }
        
        Personagem.addChild(balao2)
        
        if(!animado2){
            animado2 = true
            let scale = SKAction.scale(to: 1, duration: 1)
            let fadeIn = SKAction.fadeIn(withDuration: 1)
            
            let group = SKAction.sequence( [SKAction.group([scale, fadeIn])])
            balao2.run(group){
                self.animado2 = false
            }
        }
        
        Personagem.addChild(balao3)
        
        if(!animado3){
            animado3 = true
            let scale = SKAction.scale(to: 1, duration: 1)
            let fadeIn = SKAction.fadeIn(withDuration: 1)
            
            let group = SKAction.sequence( [SKAction.group([scale, fadeIn])])
            balao3.run(group){
                self.animado3 = false
            }
        }
        
    }
    
}
