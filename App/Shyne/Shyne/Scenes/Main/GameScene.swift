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
    var caixa : caixaDeDialogo?
    var escolhas : baloesDeEscolha?
    var indexNode : Node?
    
    override func sceneDidLoad() {
        
        makeTreeOfRoom()
        indexNode = rootNode

        self.playerNode = childNode(withName: "playerNode") as? PlayerNode
        
        physicsWorld.contactDelegate = self
        
        
    }
    
    public func drawnDialog(){
        
//        caixa = caixaDeDialogo(personagem: playerNode, texto: indexNode!.text, cena: self)
//        if(indexNode!.childrens.first != nil){
//            indexNode = indexNode!.childrens.first
//        }
//        caixa?.entrar()
        
        if(indexNode != nil){
            caixa = caixaDeDialogo(personagem: playerNode, texto: indexNode!.text, cena: self)
            indexNode = indexNode!.childrens.first
            caixa?.entrar()
        }
    }
    
    override func didMove(to view: SKView) {
        self.playerNode?.prepareControl(withCamera: camera!, inScene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.playerNode!.makePlayerWalk()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if let nome=contact.bodyA.node?.name!{
            caixa = caixaDeDialogo(personagem: contact.bodyA.node!, texto: (lista[nome]?.mensagem)!, cena: self)
            lista["caixa"]?.funcaoEntrada = {(n:caixaDeDialogo)->Void in n.entrar()}
            lista["caixa"]?.funcaoSaida = {(n:caixaDeDialogo)->Void in n.sair()}
            lista[nome]?.funcaoEntrada!(caixa!)
        }
    }
    func didEnd(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyA.node?.name!{
            print(nome)
            lista[nome]?.funcaoSaida!(caixa!)
        }
    }
}
