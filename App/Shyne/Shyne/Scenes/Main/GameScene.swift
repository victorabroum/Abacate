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
    
    override func sceneDidLoad() {

        self.playerNode = childNode(withName: "playerNode") as? PlayerNode
        
        physicsWorld.contactDelegate = self
        
        
    }
    
    override func didMove(to view: SKView) {
        self.playerNode?.prepareControl(withCamera: camera!, inScene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.playerNode!.makePlayerWalk()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if let nome=contact.bodyA.node?.name!{
            caixa = caixaDeDialogo(personagem: contact.bodyA.node!, texto: (lista[nome]?.mensagem)!)
            lista["caixa"]?.funcaoEntrada = {(n:caixaDeDialogo)->Void in n.entrar()}
            lista["caixa"]?.funcaoSaida = {(n:caixaDeDialogo)->Void in n.sair()}
            contact.bodyA.node!.addChild(caixa!)
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
