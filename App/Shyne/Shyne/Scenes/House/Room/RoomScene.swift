//
//  RoomScene.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 18/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class RoomScene: SKScene,SKPhysicsContactDelegate {
    
    var playerNode:PlayerNode?
    var dialogavel1: Dialogavel?
    
    override func sceneDidLoad() {
        print("Room didLoad")
        playerNode = self.childNode(withName: "playerNode" ) as? PlayerNode
        
        physicsWorld.contactDelegate = self
        self.dialogavel1 = Dialogavel(cena: self)
        
        //Preparando a tree story dessa scene
        makeTreeOfRoom()
        // Indicando a raiz da story
        self.dialogavel1!.indexNode = rootNode
    }
    
    override func didMove(to view: SKView) {
        print("ROOM didMove")
        playerNode?.prepareControl(withCamera: camera!, inScene: self, withCameraOffset: -1)
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.playerNode?.makePlayerWalk()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
                        print("sdsdsdsdsdsdsdsdsddsd")
        if let nome=contact.bodyA.node?.name!{
            var novoNome:String {
                get {
                    return (nome == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            
            if novoNome == "triggerCloset"{
                dialogavel1?.caixa = caixaDeDialogo(personagem: self.childNode(withName: novoNome)!, texto: (lista[novoNome]?.mensagem)!, dialogavel: dialogavel1!)
            }else if novoNome == "porta"{
                let cenaProxima:GKScene = GKScene(fileNamed: "HouseScene01")!
                if let nextScene = cenaProxima.rootNode as? HouseScene01{
                    nextScene.entities = cenaProxima.entities
                    print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
                    self.dialogavel1!.caixa = caixaDeTrocaDeCena(personagem: self.playerNode!, dialogavel: self.dialogavel1!, cenaAtual: self, cenaProxima: nextScene)
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
