//
//  HouseScene03.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 21/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class HouseScene03: SKScene,SKPhysicsContactDelegate {
    
    var playerNode: PlayerNode?
    var dialogBox01: Dialogavel?
    
    var entities = [GKEntity]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {
        self.playerNode = childNode(withName: "playerNode") as? PlayerNode
        
        // Dizendo que a scene comanda o delegate
        physicsWorld.contactDelegate = self
        // Criando a box do diálogo
        self.dialogBox01 = Dialogavel(cena: self)
        //Preparando a tree story dessa scene
        house01makeTree()
        // Indicando a raiz da story
        self.dialogBox01!.indexNode = house01Root
    }
    
    override func didMove(to view: SKView) {
        self.playerNode?.prepareControl(withCamera: camera!, inScene: self, withCameraOffset:-1)
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
            
            
            if novoNome == "porta"{
                let cenaProxima:GKScene = GKScene(fileNamed: "RoomScene02")!
                if let nextScene = cenaProxima.rootNode as? RoomScene02{
                    nextScene.entities = cenaProxima.entities
                    self.dialogBox01!.caixa = caixaDeTrocaDeCena(personagem: self.childNode(withName: "porta")!, dialogavel: self.dialogBox01!, cenaAtual: self, cenaProxima: nextScene)
                }
            }
            
            lista[novoNome]?.funcaoEntrada = {(n:caixa)->Void in n.entrar()}
            lista[novoNome]?.funcaoSaida = {(n:caixa)->Void in n.sair()}
            lista[novoNome]?.funcaoEntrada!((dialogBox01?.caixa)!)
            
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyA.node?.name!{
            
            var novoNome:String {
                get {
                    return (nome == "porta" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
        }
    }
}
