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

class HouseScene01: CustomSKSCene, SKPhysicsContactDelegate {
    
    var ballon: Ballon?
    
    private var lastUpdateTime : TimeInterval = 0
    
    // To control BG Audios
    var bgAudios: SKNode?
    
    override func sceneDidLoad() {
        
        // Dizendo que a scene comanda o delegate
        physicsWorld.contactDelegate = self
        // Criando a box do diálogo
        //Preparando a tree story dessa scene
        house01makeTree()
        prepareDialog()
    }
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        
        // Prepare BG Music
        if let bga = self.childNode(withName: "bgAudios") {
            self.bgAudios = bga
            MusicHelper.startSounds(withAudios: bgAudios!.children, withVolume: 0.2)
        }
        
        // TODO: Auto-Save
        PlayerModel.addKeys(k: "SALVEI")
        PlayerModel.savePlayer()
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyA.node?.name!{
            var novoNome:String {
                get {
                    return (nome == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            if (listaPermissoesHouse01.contains(novoNome)){
                
                if novoNome == "triggerDad"{
                    ballon = InteractionBallon(iconName: "", referenceNode: self.childNode(withName: "dad")! as! SKSpriteNode, referenceScene: self, action: {
                        let newBallon = DialogBallon.init(rootNode: house01Root, referenceScene: self)
                        newBallon.setup()
                    })
                }else if novoNome == "porta"{
                    let cenaProxima:GKScene = GKScene(fileNamed: "CityScene01")!
                    if let nextScene = cenaProxima.rootNode as? CityScene01{
                        nextScene.entities = cenaProxima.entities
                        
                        if let doorNode = self.childNode(withName: "referenceDoor") as? SKSpriteNode{
                            ballon = DoorBallon(referenceNode: doorNode, referenceScene: self, nextScene: nextScene)
                        }
                        
                        
                    }
                }else if(novoNome == "goUp"){
                    
                    
                    ballon = StairBallon(direction: "goUp", playerNode: self.playerNode!, referenceNode: self.childNode(withName: novoNome)! as! SKSpriteNode, referenceScene: self)
                    
                }else if(novoNome == "goDown"){
                    
                    
                    ballon = StairBallon(direction: "goDown", playerNode: self.playerNode!, referenceNode: self.childNode(withName: novoNome)! as! SKSpriteNode, referenceScene: self)
                    
                }else if(novoNome == "dadDoor"){
                    
                    ballon = InteractionBallon(iconName: "Icone_Locker", referenceNode: self.childNode(withName: novoNome)! as! SKSpriteNode, referenceScene: self, action: {
                        self.run(SKAction.playSoundFileNamed("door_locked", waitForCompletion: true))
                    })
                    
                }
                
                
                ballon?.setup()
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
            
            if (listaPermissoesHouse01.contains(novoNome)){
                ballon?.dismiss()
            }
            
        }
    }
    
    func prepareDialog(){
        d3_1.action = {
            print("ACTION LOCA")
            listaPermissoesHouse01.insert("porta")
            listaPermissoesHouse01.remove("triggerDad")
            self.ballon?.dismiss()
        }
        
        d3_2.action = {
            print("ACTION LOCA")
            listaPermissoesHouse01.insert("porta")
            listaPermissoesHouse01.remove("triggerDad")
            self.ballon?.dismiss()
        }
        
        d3_3.action = {
            print("ACTION LOCA")
            listaPermissoesHouse01.insert("porta")
            listaPermissoesHouse01.remove("triggerDad")
            self.ballon?.dismiss()
        }
    }
}
