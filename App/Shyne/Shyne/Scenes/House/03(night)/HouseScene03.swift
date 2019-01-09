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

class HouseScene03: CustomSKSCene, SKPhysicsContactDelegate {
    
    var ballon: Ballon?
    
    private var lastUpdateTime : TimeInterval = 0
    
    // To control BG Audios
    var bgAudios: SKNode?
    
    override func sceneDidLoad() {
        
        // Dizendo que a scene comanda o delegate
        physicsWorld.contactDelegate = self

        //Preparando a tree story dessa scene
        house03makeTree()
        
        // Ajustando dialog
        prepareDialog()
    }
    
    override func didMove(to view: SKView) {
        
        // Prepare BG Music
        if let bga = self.childNode(withName: "bgAudios") {
            self.bgAudios = bga
            MusicHelper.startSounds(withAudios: bgAudios!.children, withVolume: 0.2)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyA.node?.name!{
            var novoNome:String {
                get {
                    return (nome == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            
            
            if(listaPermissoesHouse03.contains(novoNome)){
                
                if novoNome == "porta"{
                    let cenaProxima:GKScene = GKScene(fileNamed: "RoomScene02")!
                    if let nextScene = cenaProxima.rootNode as? RoomScene02{
                        
                        nextScene.entities = cenaProxima.entities
                        ballon = DoorBallon(referenceNode: self.childNode(withName: "porta")! as! SKSpriteNode, referenceScene: self, nextScene: nextScene)
                    }
                }else if(novoNome == "goUp"){
                    
                    ballon = StairBallon(direction: "goUp", playerNode: self.playerNode!, referenceNode: self.childNode(withName: novoNome)! as! SKSpriteNode, referenceScene: self)
                    
                }else if(novoNome == "goDown"){
                    
                    ballon = StairBallon(direction: "goDown", playerNode: self.playerNode!, referenceNode: self.childNode(withName: novoNome)! as! SKSpriteNode, referenceScene: self)
                    
                }else if(novoNome == "dadDoor"){
                    
                    ballon = InteractionBallon(iconName: "Icone_Locker", referenceNode: self.childNode(withName: novoNome)! as! SKSpriteNode, referenceScene: self, action: {
                        self.run(SKAction.playSoundFileNamed("door_locked", waitForCompletion: true))
                    })
                    
                }else if novoNome == "triggerDad"{
                    
                    self.ballon = InteractionBallon(iconName: "", referenceNode: self.childNode(withName: "Dad")! as! SKSpriteNode, referenceScene: self, action: {
                        let newBallon = DialogBallon.init(rootNode: house03Root, referenceScene: self)
                        newBallon.setup()
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
            if(listaPermissoesHouse03.contains(novoNome)){
                self.ballon?.dismiss()
            }
        }
    }
    
    
    func prepareDialog() {
        house03_D5.action = {
            listaPermissoesHouse03.remove("triggerDad")
            listaPermissoesHouse03.insert("porta")
            self.ballon?.dismiss()
        }
    }
}
