//
//  CityScene02.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 21/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


class CityScene02: SKScene,SKPhysicsContactDelegate {

    var playerNode: PlayerNode?
    var entities = [GKEntity]()
    var dialogavel1: Dialogavel?
    
    override func sceneDidLoad() {
        self.playerNode = self.childNode(withName: "playerNode") as? PlayerNode
        physicsWorld.contactDelegate = self
        self.dialogavel1 = Dialogavel(cena: self)
    }
    
    override func didMove(to view: SKView) {
        self.playerNode?.prepareControl(withCamera: camera!, inScene: self, withCameraOffset: 120)
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.playerNode?.makePlayerWalk()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyA.node?.name!{
            var novoNome:String {
                get {
                    return (nome == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            
            if novoNome == "porta"{
                let cenaProxima:GKScene = GKScene(fileNamed: "HouseScene03")!
                if let nextScene = cenaProxima.rootNode as? HouseScene03{
                    nextScene.entities = cenaProxima.entities
                    self.dialogavel1!.caixa = caixaDeTrocaDeCena(personagem: self.childNode(withName: "porta")!, dialogavel: self.dialogavel1!, texture: "Icone_Door", cenaAtual: self, cenaProxima: nextScene)
                }
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
