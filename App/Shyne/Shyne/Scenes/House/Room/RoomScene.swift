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
    
    // To control BG Audios
    var bgAudios: SKNode?
    
    override func sceneDidLoad() {
        print("Room didLoad")
        playerNode = self.childNode(withName: "playerNode" ) as? PlayerNode
        
        physicsWorld.contactDelegate = self
        self.dialogavel1 = Dialogavel(cena: self)
        
        //Preparando a tree story dessa scene
        makeTreeOfRoom()
        // Indicando a raiz da story
        self.dialogavel1!.indexNode = rootNode
        
        
        
        let interactionBallon = InteractionBallon(iconName: "Icone_Door", referenceScene: self) {

            let ballon = DialogBallon(rootNode: rootNode, referenceScene: self)
            ballon.setup()
        }

        interactionBallon.setup()
        
//        let dialogBallon = DialogBallon.init(rootNode: rootNode, referenceScene: self)
//        dialogBallon.setup()
        
        
        
    }
    
    override func didMove(to view: SKView) {
        print("ROOM didMove")
        playerNode?.prepareControl(withCamera: camera!, inScene: self, withCameraOffset: -1)
        self.dialogavel1!.caixa = caixaDeDialogo(personagem: self.playerNode!, texto: "...", dialogavel: self.dialogavel1!)
        self.dialogavel1!.caixa!.entrar()
        self.playerNode?.canWalk = false
        
        // Prepare BG Music
        if let bga = self.childNode(withName: "bgAudios") {
            print("BG AUDIOS")
            self.bgAudios = bga
            MusicHelper.startSounds(withAudios: bgAudios!.children, withVolume: 0.2)
        }
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.playerNode?.makePlayerWalk()
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
            
            
          
            if novoNome == "porta"{
                let cenaProxima:GKScene = GKScene(fileNamed: "HouseScene01")!
                if let nextScene = cenaProxima.rootNode as? HouseScene01{
                    nextScene.entities = cenaProxima.entities
                    self.dialogavel1!.caixa = caixaDeTrocaDeCena(personagem: self.playerNode!, dialogavel: self.dialogavel1!, texture: "Icone_Door", cenaAtual: self, cenaProxima: nextScene)
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
