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
    var escolhas: baloesDeEscolha?
    var indexNode : Node?
    var ballon = false
    
    override func sceneDidLoad() {
        
        house01makeTree()
        indexNode = house01Root

        self.playerNode = childNode(withName: "playerNode") as? PlayerNode
        
        physicsWorld.contactDelegate = self
        
        
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
                caixa = caixaDeDialogo(personagem: playerNode!, texto: indexNode!.text, cena: self)
                caixa?.entrar()
                if(!(indexNode!.choices.isEmpty)){
                    ballon = true
                    escolhas = baloesDeEscolha(personagem: playerNode!, respostas: indexNode!.choices, cena: self)
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
            lista[nome]?.funcaoSaida!(caixa!)
        }
    }
}
