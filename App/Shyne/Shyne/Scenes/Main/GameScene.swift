//
//  GameScene.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 17/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    private var playerNode: PlayerNode?
    var dialogavel1: Dialogavel?
    
    override func sceneDidLoad() {
        

        self.playerNode = childNode(withName: "playerNode") as? PlayerNode
        
        physicsWorld.contactDelegate = self
        
        dialogavel1 = Dialogavel(cena: self)
        
        house01makeTree()
        dialogavel1!.indexNode = house01Root
        
    }
    
    override func didMove(to view: SKView) {
        self.playerNode?.prepareControl(withCamera: camera!, inScene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.playerNode!.makePlayerWalk()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyA.node?.name!{
            var novoNome:String {
                get {
                    return (nome == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }

            
            if novoNome == "dady"{
                let cenaProxima:SKScene = BakeryScene01(size: self.size)
                dialogavel1?.caixa = caixaDeTrocaDeCena(personagem: self.childNode(withName: novoNome)!, dialogavel: dialogavel1!, cenaAtual: self, cenaProxima: cenaProxima)
            }else if(novoNome == "caixa"){
                dialogavel1!.caixa = caixaDeDialogo(personagem: self.childNode(withName: "dad")!, texto: (lista[novoNome]?.mensagem)!, dialogavel: dialogavel1!)
            }
            
            lista[novoNome]?.funcaoEntrada = {(n:caixa)->Void in n.entrar()}
            lista[novoNome]?.funcaoSaida = {(n:caixa)->Void in n.sair()}
            lista[novoNome]?.funcaoEntrada!(dialogavel1!.caixa!)
        }
    }
    func didEnd(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyA.node?.name!{
            
            var novoNome:String {
                get {
                    return (nome == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            lista[novoNome]?.funcaoSaida!(dialogavel1!.caixa!)
        }
    }
}
