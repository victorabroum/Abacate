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
                    
                    let node = self.childNode(withName: newName)?.childNode(withName: "\(newName)Talk") as! SKSpriteNode
                    self.ballon = InteractionBallon(iconName: "Icon_Bus", referenceNode: node, referenceScene: self, action: {
                        self.animateBus()
                    })
                    
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

// MARK: Bus animate exit
extension HallScene02{
    func animateBus(){
        
        self.dismissPause()
        
        //Lock player
        self.playerNode!.playerCanWalk(false)
        self.offsetCamera = -1
        
        
        let wallNode = self.childNode(withName: "background")?.childNode(withName: "leftWall")
        wallNode?.position.y += 900
        
        let busNode = SKSpriteNode(imageNamed: "bus")
        self.addChild(busNode)
        busNode.xScale = 1.3
        busNode.yScale = 1.3
        busNode.zPosition = self.playerNode!.zPosition + 10
        busNode.position = CGPoint(x: -1549.75, y: -94.292)
        busNode.run(SKAction.moveTo(x: -1225.077, duration: 2)){
            self.playerNode?.run(SKAction(named: "playerWalk")!)
            self.playerNode?.run(SKAction.moveTo(x: -1317.587, duration: 2)){
                busNode.run(SKAction.moveTo(x: -1633.436, duration: 1)){
                    if let cenaProxima: GKScene = GKScene(fileNamed: "CityScene02"){
                        if let nextScene = cenaProxima.rootNode as? CityScene02{
                            
                            self.dismissPause()
                            
                            nextScene.entities = cenaProxima.entities
                            
                            //Auto-save
                            let sceneInfo = SceneInformation.init(previousScenario: "HallScene02", actualScenario: "\(nextScene.name!)")
                            PlayerModel.changeScene(scene: sceneInfo)
                            PlayerModel.savePlayer()
                            
                            let transition:SKTransition = SKTransition.fade(withDuration: 1)
                            nextScene.scaleMode = SKSceneScaleMode.aspectFill
                            self.view?.presentScene(nextScene, transition: transition)
                        }
                    }
                }
            }
        }
        
        
    }
}
