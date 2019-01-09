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

class RoomScene: CustomSKSCene,SKPhysicsContactDelegate {
    
    var playerNode:PlayerNode?
    var ballon: Ballon?
    
    // To control BG Audios
    var bgAudios: SKNode?
    
    override func sceneDidLoad() {
        print("Room didLoad")
        playerNode = self.childNode(withName: "playerNode" ) as? PlayerNode
        
        physicsWorld.contactDelegate = self
        
        //Preparando a tree story dessa scene
        makeTreeOfRoom()
    }
    
    override func didMove(to view: SKView) {
        print("ROOM didMove")
        super.didMove(to: view)
        
        playerNode?.prepareControl(withCamera: camera!, inScene: self, withCameraOffset: -1)
        
        let startBallon = InteractionBallon(iconName: "", referenceNode: playerNode!, referenceScene: self) {
            print("VAMO READY")
            self.ballon = DialogBallon.init(rootNode: rootNode, referenceScene: self)
            self.ballon!.setup()
        }
        startBallon.setup()
        
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
                    ballon = DoorBallon(referenceNode: self.childNode(withName: novoNome) as! SKSpriteNode, referenceScene: self, nextScene: nextScene)
                    ballon!.setup()
                }
            }
            
//            lista[novoNome]?.funcaoEntrada = {(n:caixa)->Void in n.entrar()}
//            lista[novoNome]?.funcaoSaida = {(n:caixa)->Void in n.sair()}
//            lista[novoNome]?.funcaoEntrada!(dialogavel1!.caixa!)
            
        }
    }
    func didEnd(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyA.node?.name!{
            
            var novoNome:String {
                get {
                    return (nome == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            ballon?.dismiss()
        }
    }
    
}
