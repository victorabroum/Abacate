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
    
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {
    
        super.sceneDidLoad()
        
        // Dizendo que a scene comanda o delegate
        physicsWorld.contactDelegate = self

        //Preparando a tree story dessa scene
        house03makeTree()
        
    }
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        
        self.offsetCamera = 85
        
        // Ajustando dialog
        prepareDialog()
        
        // Insert Keys on DAO
        PlayerModel.addKeys(k: "goUp")
        PlayerModel.addKeys(k: "goDown")
        PlayerModel.addKeys(k: "dadDoor")
        PlayerModel.addKeys(k: "triggerDad")
        
        // Prepare BG Music
        if let bga = self.childNode(withName: "bgAudios") {
            self.bgAudios = bga
            MusicHelper.startSounds(withAudios: bgAudios!.children, withVolume: 0.2)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let name=contact.bodyA.node?.name!{
            var newName:String {
                get {
                    return (name == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            // TODO: Use DAO
            if(PlayerModel.getInstance().keys.contains(newName)){
                if newName == "porta"{
                    let cenaProxima:GKScene = GKScene(fileNamed: "RoomScene02")!
                    if let nextScene = cenaProxima.rootNode as? RoomScene02{
                        
                        nextScene.entities = cenaProxima.entities
                        ballon = DoorBallon(referenceNode: self.childNode(withName: "porta")! as! SKSpriteNode, referenceScene: self, nextScene: nextScene)
                    }
                }else if(newName == "goUp"){
                    
                    ballon = StairBallon(direction: "goUp", playerNode: self.playerNode!, referenceNode: self.childNode(withName: newName)! as! SKSpriteNode, referenceScene: self)
                    
                }else if(newName == "goDown"){
                    
                    ballon = StairBallon(direction: "goDown", playerNode: self.playerNode!, referenceNode: self.childNode(withName: newName)! as! SKSpriteNode, referenceScene: self)
                    
                }else if(newName == "dadDoor"){
                    
                    ballon = InteractionBallon(iconName: "Icone_Locker", referenceNode: self.childNode(withName: newName)! as! SKSpriteNode, referenceScene: self, action: {
                        self.run(SKAction.playSoundFileNamed("door_locked", waitForCompletion: true))
                    })
                    
                }else if newName == "triggerDad"{
                    
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
        if let name=contact.bodyA.node?.name!{
            
            var newName:String {
                get {
                    return (name == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }

            }
            
            if(PlayerModel.getInstance().keys.contains(newName)){
                self.ballon?.dismiss()
            }
            
        }
    }
    
    
    func prepareDialog() {
        house03d05.action = {
            
            PlayerModel.addKeys(k: "porta")
            // TODO: Remove key from DAO
            self.ballon?.dismiss()
        }
    }
}
