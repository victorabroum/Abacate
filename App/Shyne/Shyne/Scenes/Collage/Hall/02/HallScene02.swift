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
        PlayerModel.addKeys(k: "anaCollider")
        
        
        
        // Start idle for Ana
        if let node = self.childNode(withName: "anaNode") {
            node.run(SKAction(named: "anna_idle")!)
        }
        
        hall02Fd09.action = {
            PlayerModel.removeKey(k: "anaCollider")
            self.anaAnimate()
        }
        
        hall02Td06.action = {
            PlayerModel.removeKey(k: "anaCollider")
            self.anaAnimate()
        }
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        // Make tree for scene
        hall02MakeTree()
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
                }else if(newName == "anaCollider"){
                    self.ballon = DialogBallon(rootNode: hall02Root, referenceScene: self)
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

// MARK: Ana animation exiting
extension HallScene02{
    func anaAnimate(){
        let anaNode = self.childNode(withName: "anaNode") as! SKSpriteNode
        anaNode.xScale *= -1
        
        anaNode.size = CGSize(width: 87.4, height: 191.59)
        anaNode.run(SKAction(named: "anna_walk")!)
        
        anaNode.run(SKAction.moveBy(x: -200, y: 0, duration: 1.5)){
            self.ballon?.dismiss()
            anaNode.removeFromParent()
        }
    }
}
