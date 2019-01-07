//
//  HouseScene01.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 21/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class HouseScene01: SKScene, SKPhysicsContactDelegate {
    
    var playerNode: PlayerNode?
    var ballon: Ballon?
    
    var entities = [GKEntity]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    // To control BG Audios
    var bgAudios: SKNode?
    
    override func sceneDidLoad() {
        self.playerNode = childNode(withName: "playerNode") as? PlayerNode
        
        // Dizendo que a scene comanda o delegate
        physicsWorld.contactDelegate = self
        // Criando a box do diálogo
        //Preparando a tree story dessa scene
        house01makeTree()
        // Indicando a raiz da story
    }
    
    override func didMove(to view: SKView) {
        print("ANTES SIZE \((self.playerNode?.yScale)!)") 
        self.playerNode?.prepareControl(withCamera: camera!, inScene: self, withCameraOffset:-1)
        
        // Prepare BG Music
        if let bga = self.childNode(withName: "bgAudios") {
            self.bgAudios = bga
            MusicHelper.startSounds(withAudios: bgAudios!.children, withVolume: 0.2)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.playerNode!.makePlayerWalk()
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
            
            print(novoNome)
            if novoNome == "triggerDad"{
                
                ballon = InteractionBallon(iconName: "", referenceNode: self.childNode(withName: "dad")! as! SKSpriteNode, referenceScene: self, action: {
                    let newBallon = DialogBallon.init(rootNode: house01Root, referenceScene: self)
                    newBallon.setup()
                })
                ballon?.setup()
            }else if novoNome == "porta"{
                let cenaProxima:GKScene = GKScene(fileNamed: "CityScene01")!
                if let nextScene = cenaProxima.rootNode as? CityScene01{
                    nextScene.entities = cenaProxima.entities
                    ballon = DoorBallon(referenceNode: self.childNode(withName: "referenceDoor")! as! SKSpriteNode, referenceScene: self, nextScene: nextScene)
                    ballon?.setup()
                }
            }else if(novoNome == "goUp"){
                
                
                ballon = StairBallon(direction: "goUp", playerNode: self.playerNode!, referenceNode: self.childNode(withName: novoNome)! as! SKSpriteNode, referenceScene: self)
                ballon?.setup()
                
            }else if(novoNome == "goDown"){
                
                
                ballon = StairBallon(direction: "goDown", playerNode: self.playerNode!, referenceNode: self.childNode(withName: novoNome)! as! SKSpriteNode, referenceScene: self)
                ballon?.setup()
                
            }else if(novoNome == "dadDoor"){
                
                ballon = InteractionBallon(iconName: "Icone_Locker", referenceNode: self.childNode(withName: novoNome)! as! SKSpriteNode, referenceScene: self, action: {
                    self.run(SKAction.playSoundFileNamed("door_locked", waitForCompletion: true))
                })
                ballon?.setup()
                
            }
            
            
            
//            if (listaPermissoesHouse01.contains(novoNome)){
//                lista[novoNome]?.funcaoEntrada = {(n:caixa)->Void in n.entrar()}
//                lista[novoNome]?.funcaoSaida = {(n:caixa)->Void in n.sair()}
//                lista[novoNome]?.funcaoEntrada!(self.dialogBox01!.caixa!)
//            }
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
            
//            if (listaPermissoesHouse01.contains(novoNome)){
//                lista[novoNome]?.funcaoSaida!(self.dialogBox01!.caixa!)
//            }
        }
    }
}
