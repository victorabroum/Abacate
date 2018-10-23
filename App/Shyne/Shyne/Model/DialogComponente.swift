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
    var dialogavel1: Dialogavel
    
    init(personagem: SKNode, texto: String, dialogavel: Dialogavel) {
        Personagem = personagem
        Texto = texto
        dialogavel1 = dialogavel
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
        dialogavel1.drawnDialog()
    }

}

class Balao: SKSpriteNode{
    
    let Resposta: Answer
    var dialogavel1: Dialogavel
    
    init(resposta: Answer, dialogavel: Dialogavel) {
        Resposta = resposta
        dialogavel1 = dialogavel
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
           dialogavel1.changeIndexNodeBallon(node: Resposta.child)
        }
        dialogavel1.drawnDialog()
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
    var dialogavel1: Dialogavel
    
    init(personagem: SKSpriteNode, respostas:[Answer], dialogavel: Dialogavel) {
        Personagem = personagem
        Respostas = respostas
        dialogavel1 = dialogavel
        
        balao1 = Balao(resposta: Respostas[0], dialogavel: dialogavel1)
        balao2 = Balao(resposta: Respostas[1], dialogavel: dialogavel1)
        balao3 = Balao(resposta: Respostas[2], dialogavel: dialogavel1)
        balao1.position = CGPoint(x: -150, y: 100)
        balao2.position = CGPoint(x: 150, y: 170)
        balao3.position = CGPoint(x: 0, y: 240)
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

class Dialogavel{
    var caixa : caixaDeDialogo?
    var escolhas: baloesDeEscolha?
    var indexNode : Node?
    var ballon = false
    var playerNode: PlayerNode?
    var cena: SKScene
    
    init(cena: SKScene) {
        self.cena = cena
        if let p = self.cena.childNode(withName: "playerNode") as? PlayerNode{
            self.playerNode = p
        }
    }
    
    
    public func changeIndexNodeBallon(node: [Node]){
        indexNode = node.first
        
    }
    
    public func drawnDialog(){
        
        //        caixa = caixaDeDialogo(personagem: playerNode, texto: indexNode!.text, cena: self)
        //        if(indexNode!.childrens.first != nil){
        //            indexNode = indexNode!.childrens.first
        //        }
        //        caixa?.entrar()
        
        if(!ballon){
            if(indexNode != nil){
                self.playerNode!.playerCanWalk(false)
                if(escolhas != nil){
                    escolhas?.sair()
                }
                caixa = caixaDeDialogo(personagem: indexNode!.getNodeReference(named: indexNode!.nodeToTalk, inScene: self.cena)!, texto: indexNode!.text, dialogavel: self)
                caixa?.entrar()
                if(!(indexNode!.choices.isEmpty)){
                    ballon = true
                    escolhas = baloesDeEscolha(personagem: playerNode!, respostas: indexNode!.choices, dialogavel: self)
                }
                else{
                    indexNode = indexNode!.childrens.first
                }
            }
            else{
                self.playerNode!.playerCanWalk(true)
            }
        }
        else{
            escolhas?.desenhar()
            ballon = false
            indexNode = indexNode!.childrens.first
        }
    }
}