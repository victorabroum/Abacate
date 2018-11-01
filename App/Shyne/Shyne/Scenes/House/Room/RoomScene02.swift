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
    var entities = [GKEntity]()
    
    // To control BG Audios
    var bgAudios: SKNode?
    
    override func sceneDidLoad() {
        playerNode = self.childNode(withName: "playerNode" ) as? PlayerNode
        
        physicsWorld.contactDelegate = self
        self.dialogavel1 = Dialogavel(cena: self)
        // Indicando a raiz da story
        self.dialogavel1!.indexNode = room02Root
        
        room02Root.action = {
            let cenaProxima = SKScene(fileNamed: "EndGame")
            
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            cenaProxima!.scaleMode = SKSceneScaleMode.aspectFill
            self.view?.presentScene(cenaProxima!, transition: transition)
            
        }
        
    }
    
    override func didMove(to view: SKView) {
        self.playerNode?.prepareControl(withCamera: camera!, inScene: self, withCameraOffset: -1)
        
        // Prepare BG Music
        if let bga = self.childNode(withName: "bgAudios") {
            self.bgAudios = bga
            MusicHelper.startSounds(withAudios: bgAudios!.children, withVolume: 0.2)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.playerNode?.makePlayerWalk()
        if(dialogavel1?.indexNode == nil){
            listaPermissoesRoom02.remove("cama")
        }
    }
    
    override func willMove(from view: SKView) {
        if self.bgAudios != nil{
            MusicHelper.stopSounds(withAudios: self.bgAudios!.children)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyA.node?.name!{
            var novoNome:String {
                get {
                    return (nome == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            
            if novoNome == "cama"{
                dialogavel1!.caixa = caixaDeDialogo(personagem: self.childNode(withName: novoNome)!, texto: (lista[novoNome]?.mensagem)!, dialogavel: self.dialogavel1!)
            }
            if(listaPermissoesRoom02.contains(novoNome)){
                lista[novoNome]?.funcaoEntrada = {(n:caixa)->Void in n.entrar()}
                lista[novoNome]?.funcaoSaida = {(n:caixa)->Void in n.sair()}
                lista[novoNome]?.funcaoEntrada!(dialogavel1!.caixa!)
            }
        }
    }
    func didEnd(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyA.node?.name!{
            
            var novoNome:String {
                get {
                    return (nome == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            if(listaPermissoesRoom02.contains(novoNome)){
                lista[novoNome]?.funcaoSaida!(dialogavel1!.caixa!)
            }
        }
    }
}
