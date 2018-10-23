//
//  RoomScene.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 18/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit

class RoomScene: SKScene,SKPhysicsContactDelegate {
    
    var playerNode:PlayerNode?
    var dialogavel1: Dialogavel?
    
    override func sceneDidLoad() {
        print("Room didLoad")
        playerNode = self.childNode(withName: "playerNode" ) as? PlayerNode
        
        physicsWorld.contactDelegate = self
    }
    
    override func didMove(to view: SKView) {
        print("ROOM didMove")
        playerNode?.prepareControl(withCamera: camera!, inScene: self, withCameraOffset: -1)
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
            
            
            if novoNome == "armario"{
                dialogavel1?.caixa = caixaDeDialogo(personagem: self.childNode(withName: novoNome)!, texto: (lista[novoNome]?.mensagem)!, dialogavel: dialogavel1!)
            }
            
            lista[novoNome]?.funcaoEntrada = {(n:caixaDeDialogo)->Void in n.entrar()}
            lista[novoNome]?.funcaoSaida = {(n:caixaDeDialogo)->Void in n.sair()}
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
