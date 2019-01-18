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
        PlayerModel.addKeys(k: "pcCollider")
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
                    
                }else if (newName == "pcCollider"){
                    if !(PlayerModel.getInstance().keys.contains("Email")){
                        
                        
                        
                        if (PlayerModel.getInstance().keys.contains("Delisgar")){
                            self.ballon = InteractionBallon(iconName: "icon_computer", referenceNode: self.childNode(withName: "pcCollider") as! SKSpriteNode, referenceScene: self, action: {
                                let choices = ChoicesBallon(choices: [room02c01PC, room02c02PC], referenceScene: self)
                                choices.setup()
                            })
                        }else{
                            self.ballon = InteractionBallon(iconName: "icon_computer", referenceNode: self.childNode(withName: "pcCollider") as! SKSpriteNode, referenceScene: self, action: {
                                self.ballon = DialogBallon(rootNode: room02d01PC, referenceScene: self)
                                self.ballon!.setup()
                            })
                        }
                        
                    }
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
        
        room02d01PC.action = {
            
            PlayerModel.removeKey(k: "Desligar")
            PlayerModel.removeKey(k: "pcCollider")
            
            // Chama a Scene dele no pc
            let onComputerNode = SKSpriteNode(imageNamed: "Email_Avocad")
            let constScale: CGFloat = 3
            onComputerNode.xScale = constScale
            onComputerNode.yScale = constScale
            onComputerNode.zPosition = 900
            
            onComputerNode.run(SKAction.fadeIn(withDuration: 0.5))
            
            self.camera!.addChild(onComputerNode)
            
            
            // MARK: Talk on Computer
            let ballonNodeRef = SKSpriteNode(texture: nil, color: .clear, size: CGSize(width: 10, height: 10))
            ballonNodeRef.name = "pcTalk"
            ballonNodeRef.zPosition = onComputerNode.zPosition + 10
            ballonNodeRef.position.x += 270
            ballonNodeRef.position.y += 30
            self.addChild(ballonNodeRef)
            
            self.ballon = DialogBallon.init(rootNode: room02dOnPC01, referenceNode: ballonNodeRef, referenceScene: self)
            self.ballon!.setup()
            
            room02dOnPC04.action = {
                
                onComputerNode.run(SKAction.fadeOut(withDuration: 0.5))
                self.ballon!.dismiss()
            }
            
        }
        
    }
}
