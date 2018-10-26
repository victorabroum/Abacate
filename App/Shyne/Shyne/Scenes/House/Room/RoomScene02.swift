//
//  RoomScene02.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 21/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class RoomScene02: SKScene,SKPhysicsContactDelegate {
    
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
        self.playerNode?.prepareControl(withCamera: camera!, inScene: self, withCameraOffset: -1)
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
            
            
            if novoNome == "cama"{
                dialogavel1!.caixa = caixaDeEscada(personagem: self.childNode(withName: novoNome)!, dialogavel: dialogavel1!,function: {(()->Void).self})
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
