//
//  HallScene02.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 14/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class HallScene02: CustomSKSCene, SKPhysicsContactDelegate {
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        self.offsetCamera = 55
        self.physicsWorld.contactDelegate = self
        
        // Add Keys for Player
        PlayerModel.addKeys(k: "collegeBusStop")
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if let name=contact.bodyA.node?.name!{
            var newName:String {
                get {
                    return (name == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            if(PlayerModel.getInstance().keys.contains(newName)){
                
                if newName == "collegeBusStop"{
                    
                    
                    if let cenaProxima: GKScene = GKScene(fileNamed: "CityScene02"){
                        if let nextScene = cenaProxima.rootNode as? CustomSKSCene{
                            
                            nextScene.entities = cenaProxima.entities
                            
                            ballon = DoorBallon.init(referenceNode: self.childNode(withName: newName)?.childNode(withName: "\(newName)Talk") as! SKSpriteNode, referenceScene: self, nextScene: nextScene)
                        }
                    }
                    
                    
                    
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
    
}
