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

class RoomScene02: CustomSKSCene, SKPhysicsContactDelegate {
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        physicsWorld.contactDelegate = self
        
        // Prepare Dialog
        prepareDialog()
        room02MakeTree()
    }
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        
        self.offsetCamera = 55
        
        PlayerModel.addKeys(k: "cama")
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let name=contact.bodyA.node?.name!{
            var newName:String {
                get {
                    return (name == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            if(PlayerModel.getInstance().keys.contains(newName)){
                if newName == "cama"{
                    
                    self.ballon = InteractionBallon(iconName: "", referenceNode: self.childNode(withName: "cama") as! SKSpriteNode, referenceScene: self, action: {
                        let newBallon = DialogBallon.init(rootNode: room02Root, referenceScene: self)
                        newBallon.setup()
                    })
                    
                }
                
                self.ballon?.setup()
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
    
    func prepareDialog(){
        
        room02c01.function = {
            
            
            let cenaProxima = SKScene(fileNamed: "EndGame")
            
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            cenaProxima!.scaleMode = SKSceneScaleMode.aspectFill
            self.view?.presentScene(cenaProxima!, transition: transition)
            
        }
        
        room02c02.function = room02c01.function
        room02c03.function = room02c01.function
        
    }
}
