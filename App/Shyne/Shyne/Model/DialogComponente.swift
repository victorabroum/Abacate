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
    var animado: Bool
    var Cena: GameScene
    
    init(personagem: SKNode, texto: String, cena: GameScene) {
        Personagem = personagem
        Texto = texto
        Cena = cena
        animado = false
        
        super.init(texture: nil, color: .white, size: CGSize(width: 100, height: 50))
        isUserInteractionEnabled = true
        self.setScale(0)
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
    
    func entrar()->Void{
        Personagem.addChild(self)
        
        if(!animado){
            animado = true
            let moveDown : SKAction
            
            if(Personagem.position.y == CGFloat(0)){
                moveDown = SKAction.moveTo(y: -150, duration: 0.3)
            }
            else{
                moveDown = SKAction.moveTo(y: 150, duration: 0.3)
            }
            
            let scale = SKAction.scale(to: 1, duration: 0.3)
            let fadeIn = SKAction.fadeIn(withDuration: 0.3)
            
            let group = SKAction.sequence( [SKAction.group([moveDown, scale, fadeIn])])
            self.run(group){
                self.animado = false
            }
        }
    }
    
    func sair()->Void{
        if(!animado){
            animado = true
            let scale = SKAction.scale(to: 0, duration: 0.1)
            let fadeIn = SKAction.fadeIn(withDuration: 0.1)
            let group = SKAction.group([scale, fadeIn])
            self.run(group){
                self.animado = false
            }
        }
        self.removeFromParent()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //adiciona o valor ao status da historia
        sair()
        Cena.drawnDialog()
    }

}

class Balao: SKSpriteNode{
    
    let Resposta: Answer
    var Cena: GameScene
    
    init(resposta: Answer, cena: GameScene) {
        Resposta = resposta
        Cena = cena
        super.init(texture: nil, color: .white, size: CGSize(width: 100, height: 50))
        isUserInteractionEnabled = true
        self.setScale(0)
        self.zPosition = 1000
        
        let text = SKLabelNode(text: Resposta.text)
        text.fontName = "Chalkduster"
        text.position = CGPoint(x: 0, y: 0)
        text.fontColor = .black
        self.addChild(text)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //adiciona o valor ao status da historia
        if(!(Resposta.child.isEmpty)){
            Cena.changeIndexNodeBallon(node: Resposta.child)
        }
        Cena.drawnDialog()
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
    let Respostas : [Answer]
    var Cena: GameScene
    
    init(personagem: SKSpriteNode, respostas:[Answer], cena: GameScene) {
        Personagem = personagem
        Respostas = respostas
        Cena = cena
        
        balao1 = Balao(resposta: Respostas[0], cena: cena)
        balao2 = Balao(resposta: Respostas[1], cena: cena)
        balao3 = Balao(resposta: Respostas[2], cena: cena)
        balao1.position = CGPoint(x: -150, y: 100)
        balao2.position = CGPoint(x: 150, y: 100)
        balao3.position = CGPoint(x: 0, y: 100)
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
    
    func sair()->Void{
        if(!animado1){
            animado1 = true
            let scale = SKAction.scale(to: 0, duration: 0.1)
            let fadeIn = SKAction.fadeIn(withDuration: 0.1)
            let group = SKAction.group([scale, fadeIn])
            balao1.run(group){
                self.animado1 = false
            }
        }
        balao1.removeFromParent()
        
        if(!animado2){
            animado2 = true
            let scale = SKAction.scale(to: 0, duration: 0.1)
            let fadeIn = SKAction.fadeIn(withDuration: 0.1)
            let group = SKAction.group([scale, fadeIn])
            balao2.run(group){
                self.animado2 = false
            }
        }
        balao2.removeFromParent()
        
        if(!animado3){
            animado3 = true
            let scale = SKAction.scale(to: 0, duration: 0.1)
            let fadeIn = SKAction.fadeIn(withDuration: 0.1)
            let group = SKAction.group([scale, fadeIn])
            balao3.run(group){
                self.animado3 = false
            }
        }
        balao3.removeFromParent()
    }
    
}
