//
//  DialogComponente.swift
//  Shyne
//
//  Created by Nickson Kley Gonçalves Da Silva on 17/10/2018.
//  Copyright © 2018 Abacate. All rights reserved.
//

import SpriteKit

class caixa: SKSpriteNode{
    var Personagem: SKNode
    var Texto: String
    var dialogavel1: Dialogavel
    var animado: Bool
    let text: SKLabelNode?
    var rect : CGRect?
    
    init(personagem: SKNode, texto: String, dialogavel: Dialogavel){
        Personagem = personagem
        Texto = texto
        dialogavel1 = dialogavel
        animado = false
        text = SKLabelNode(text: texto)
        
        super.init(texture: nil, color: .white, size: CGSize(width: 0, height: 0))
        isUserInteractionEnabled = true
        
        self.zPosition = 1000
        self.alpha = 1
        text!.numberOfLines = 3
        text!.fontName = "Futura"
        text!.fontSize = 20
        text!.position = CGPoint(x: 0, y: 0)
        text!.horizontalAlignmentMode = .center
        text!.verticalAlignmentMode = .center
        //self.texture = SKTexture(imageNamed: "dialogue_box_top")
        
        print("\(dialogavel.cena.size.height * dialogavel.cena.size.width)")

        self.size.width = text!.frame.size.width+10
        self.size.height = text!.frame.size.height+10
        self.rect = self.frame
        self.setScale(0)
        text!.fontColor = .black
        
        self.addChild(text!)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func entrar()->Void{
        
        Personagem.addChild(self)
        
        
        if(!animado){
            animado = true
            let moveDown : SKAction
            
            //if(Personagem.position.y == CGFloat(0)){
            //    moveDown = SKAction.moveTo(y: CGFloat(-70 * Texto.split(separator: "\n").count), duration: 0.3)
            //}
            //else{
            moveDown = SKAction.moveTo(y: (((Personagem.frame.size.height)/2) + rect!.height), duration: 0.3)
            //}
            
            let  scalex: SKAction
            
            if(self.Personagem.xScale<0){
                scalex = SKAction.scaleX(to: -1, duration: 0.3)
                
            }else{
                scalex = SKAction.scaleX(to: 1, duration: 0.3)
            }
            
            let scale = SKAction.scaleY(to: 1, duration: 0.3)
            
            let fadeIn = SKAction.fadeIn(withDuration: 0.3)
            
            let group = SKAction.sequence( [SKAction.group([moveDown,scalex,  scale, fadeIn])])
            self.run(group){
                self.animado = false
            }
        }
    }
    
    func sair()->Void{
        if(!animado){
            animado = true
            let scale = SKAction.scale(to: 0, duration: 0.3)
            let fadeIn = SKAction.fadeIn(withDuration: 0.3)
            let group = SKAction.group([scale, fadeIn])
            self.run(group){
                self.animado = false
            }
        }
        self.removeFromParent()
    }
    
}

class Transicao{
    var cenaAtual: SKScene
    var cenaProxima: SKScene
    
    init(cenaAtual: SKScene, cenaProxima: SKScene) {
        self.cenaAtual = cenaAtual
        self.cenaProxima = cenaProxima
    }
    
    func troca(){
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        cenaProxima.scaleMode = SKSceneScaleMode.aspectFill
        cenaAtual.view?.presentScene(cenaProxima, transition: transition)
    }
}

class caixaDeTrocaDeCena: caixa{
    var cenaAtual: SKScene
    var cenaProxima: SKScene
    var transicao: Transicao?
    
    init(personagem: SKNode, dialogavel: Dialogavel, cenaAtual: SKScene, cenaProxima: SKScene){
        self.cenaAtual = cenaAtual
        self.cenaProxima = cenaProxima
        super.init(personagem: personagem, texto: "...", dialogavel: dialogavel)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.transicao = Transicao(cenaAtual: cenaAtual, cenaProxima: cenaProxima)
        self.transicao!.troca()
    }
}

class caixaDeEscada: caixa{
    var personagem: SKNode
    var function: ()->Void
    
    init(personagem: SKNode, dialogavel: Dialogavel, function: @escaping ()->Void) {
        self.personagem = personagem
        self.function = function
        super.init(personagem: self.personagem, texto: "...", dialogavel: dialogavel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.function()
    }
}

class caixaDeDialogo: caixa{
//    var Personagem: SKNode
//    var Texto: String
//    var animado: Bool
//    var dialogavel1: Dialogavel
    
    override init(personagem: SKNode, texto: String, dialogavel: Dialogavel) {
        super.init(personagem: personagem, texto: texto, dialogavel: dialogavel)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    let text : SKLabelNode
    var function: (()->Void)?
    var rect : CGRect?
    
    init(resposta: Answer, dialogavel: Dialogavel) {
        Resposta = resposta
        dialogavel1 = dialogavel
        text = SKLabelNode(text: Resposta.text)
        super.init(texture: nil, color: .white, size: CGSize(width: 100, height: 50))
        self.function = self.nextBalon
        isUserInteractionEnabled = true
        
        self.zPosition = 1000
        
        text.numberOfLines = 3
        text.fontSize = 20
        text.fontName = "Futura"
        text.position = CGPoint(x: 0, y: 0)
        text.horizontalAlignmentMode = .center
        text.verticalAlignmentMode = .center
        
        self.size.width = text.frame.size.width+10
        self.size.height = text.frame.size.height+10
        
        rect = self.frame
        
        self.setScale(0)
        text.fontColor = .black
        
        self.addChild(text)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //adiciona o valor ao status da historia
        happyStatus += Resposta.amount.happy
        normalStatus += Resposta.amount.normal
        shyStatus += Resposta.amount.shy
        function!()
    }
    
    func nextBalon(){
        if(self.Resposta.child.count == 0){
            dialogavel1.escolhas?.sair()
            dialogavel1.indexNode = Resposta.child.first
        }
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
    var function: (()->Void)?
    
    init(personagem: SKSpriteNode, respostas:[Answer], dialogavel: Dialogavel) {
        Personagem = personagem
        Respostas = respostas
        dialogavel1 = dialogavel
        
        balao1 = Balao(resposta: Respostas[0], dialogavel: dialogavel1)
        if(Respostas[0].function != nil){
            balao1.function = Respostas[0].function
        }
        balao2 = Balao(resposta: Respostas[1], dialogavel: dialogavel1)
        if(Respostas[1].function != nil){
            balao2.function = Respostas[1].function
        }
        balao3 = Balao(resposta: Respostas[2], dialogavel: dialogavel1)
        if(Respostas[2].function != nil){
            balao3.function = Respostas[2].function
        }
        //balao1.texture = SKTexture(imageNamed: "dialogue_box_")
        balao1.position = CGPoint(x: -1*((dialogavel.playerNode!.frame.size.width/2)+(balao1.rect!.width/2)), y: 0)
        balao2.position = CGPoint(x: 0, y: (dialogavel.playerNode!.frame.size.height/2)+balao2.rect!.height)
        balao3.position = CGPoint(x: ((dialogavel.playerNode!.frame.size.width/2)+(balao3.rect!.width/2)), y: 0)
    }
    
    func desenhar(){
        Personagem.addChild(balao1);
        
        if(!animado1){
            animado1 = true
            let  scalex: SKAction
            if(self.Personagem.xScale<0){
                scalex = SKAction.scaleX(to: -1, duration: 0.3)
                
            }else{
                scalex = SKAction.scaleX(to: 1, duration: 0.3)
            }
            
            let scale = SKAction.scaleY(to: 1, duration: 0.3)
            
            let fadeIn = SKAction.fadeIn(withDuration: 0.3)
            
            let group = SKAction.sequence( [SKAction.group([scalex, scale, fadeIn])])
            balao1.run(group){
                self.animado1 = false
            }
            
        }
        
        Personagem.addChild(balao2)
        
        if(!animado2){
            animado2 = true
            let  scalex: SKAction
            if(self.Personagem.xScale<0){
                scalex = SKAction.scaleX(to: -1, duration: 0.3)
                
            }else{
                scalex = SKAction.scaleX(to: 1, duration: 0.3)
            }
            
            let scale = SKAction.scaleY(to: 1, duration: 0.3)
            
            let fadeIn = SKAction.fadeIn(withDuration: 0.3)
            
            let group = SKAction.sequence( [SKAction.group([scalex, scale, fadeIn])])
            balao2.run(group){
                self.animado2 = false
            }
        }
        
        Personagem.addChild(balao3)
        
        if(!animado3){
            animado3 = true
            let  scalex: SKAction
            if(self.Personagem.xScale<0){
                scalex = SKAction.scaleX(to: -1, duration: 0.3)
                
            }else{
                scalex = SKAction.scaleX(to: 1, duration: 0.3)
            }
            
            let scale = SKAction.scaleY(to: 1, duration: 0.3)
            
            let fadeIn = SKAction.fadeIn(withDuration: 0.3)
            
            let group = SKAction.sequence( [SKAction.group([scalex, scale, fadeIn])])

            balao3.run(group){
                self.animado3 = false
            }
        }
        
    }
    
    func sair()->Void{
        if(!animado1){
            animado1 = true
            let scale = SKAction.scale(to: 0, duration: 0.3)
            let fadeIn = SKAction.fadeIn(withDuration: 0.3)
            let group = SKAction.group([scale, fadeIn])
            balao1.run(group){
                self.animado1 = false
            }
        }
        balao1.removeFromParent()
        
        if(!animado2){
            animado2 = true
            let scale = SKAction.scale(to: 0, duration: 0.3)
            let fadeIn = SKAction.fadeIn(withDuration: 0.3)
            let group = SKAction.group([scale, fadeIn])
            balao2.run(group){
                self.animado2 = false
            }
        }
        balao2.removeFromParent()
        
        if(!animado3){
            animado3 = true
            let scale = SKAction.scale(to: 0, duration: 0.3)
            let fadeIn = SKAction.fadeIn(withDuration: 0.3)
            let group = SKAction.group([scale, fadeIn])
            balao3.run(group){
                self.animado3 = false
            }
        }
        balao3.removeFromParent()
    }
    
}

class Dialogavel{
    var caixa : caixa?
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
