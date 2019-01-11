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
    
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
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
        
        
        PlayerModel.addKeys(k: "triggerDad")
        PlayerModel.addKeys(k: "goUp")
        PlayerModel.addKeys(k: "goDown")
        PlayerModel.addKeys(k: "dadDoor")
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let name=contact.bodyA.node?.name!{
            var newName:String {
                get {
                    return (name == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            if(PlayerModel.getInstance().keys.contains(newName)){
                if newName == "triggerDad"{
                    ballon = InteractionBallon(iconName: "", referenceNode: self.childNode(withName: "dad")! as! SKSpriteNode, referenceScene: self, action: {
                        let newBallon = DialogBallon.init(rootNode: house01Root, referenceScene: self)
                        newBallon.setup()
                    })
                }else if newName == "porta"{
                    let cenaProxima:GKScene = GKScene(fileNamed: "CityScene01")!
                    if let nextScene = cenaProxima.rootNode as? CityScene01{
                        nextScene.entities = cenaProxima.entities
                        
                        if let doorNode = self.childNode(withName: "referenceDoor") as? SKSpriteNode{
                            ballon = DoorBallon(referenceNode: doorNode, referenceScene: self, nextScene: nextScene)
                        }
                    }
                }else if(newName == "goUp"){
                    
                    
                    ballon = StairBallon(direction: "goUp", playerNode: self.playerNode!, referenceNode: self.childNode(withName: newName)! as! SKSpriteNode, referenceScene: self)
                    
                }else if(newName == "goDown"){
                    
                    
                    ballon = StairBallon(direction: "goDown", playerNode: self.playerNode!, referenceNode: self.childNode(withName: newName)! as! SKSpriteNode, referenceScene: self)
                    
                }else if(newName == "dadDoor"){
                    
                    ballon = InteractionBallon(iconName: "Icone_Locker", referenceNode: self.childNode(withName: newName)! as! SKSpriteNode, referenceScene: self, action: {
                        self.run(SKAction.playSoundFileNamed("door_locked", waitForCompletion: true))
                    })
                }
                
                ballon?.setup()
            }
        }
    }
    func didEnd(_ contact: SKPhysicsContact) {
        if let name=contact.bodyA.node?.name!{
            
            var newName:String {
                get {
                    return (name == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            if(PlayerModel.getInstance().keys.contains(newName)){
                ballon?.dismiss()
            }
            
        }
    }
    
    func prepareDialog(){
        house01d04.action = {
            
            PlayerModel.addKeys(k: "porta")
            PlayerModel.addKeys(k: "bakeryDoor")
            self.ballon?.dismiss()
        }
        
//        d3_2.action = {
//            
//            PlayerModel.addKeys(k: "porta")
//            PlayerModel.addKeys(k: "bakeryDoor")
//            self.ballon?.dismiss()
//        }
//        
//        d3_3.action = {
//            
//            PlayerModel.addKeys(k: "porta")
//            PlayerModel.addKeys(k: "bakeryDoor")
//            self.ballon?.dismiss()
//        }
    }
}
