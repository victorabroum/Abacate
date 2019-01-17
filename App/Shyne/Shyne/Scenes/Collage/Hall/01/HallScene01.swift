//
//  HallScene01.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 14/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class HallScene01: CustomSKSCene, SKPhysicsContactDelegate{
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        physicsWorld.contactDelegate = self
        
        // Add Keys on Player
        PlayerModel.addKeys(k: "collegeDoor")
        
        hall01MakeTree()
        
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.animteArrive()
        
        let firulasController = FirulasController(scene: self)
        firulasController.addJennifer(withRandom: false, withScale: 0.2, yPosition: -127, withDuration: TimeInterval.random(in: 80...100))
        firulasController.addFred(withRandom: false, withScale: 0.2, yPosition: -116, withDuration: TimeInterval.random(in: 80...100))
        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if let name=contact.bodyA.node?.name!{
            var newName:String {
                get {
                    return (name == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            if(PlayerModel.getInstance().keys.contains(newName)){
                
                if newName == "collegeDoor"{
                    
                    
                    if let cenaProxima: GKScene = GKScene(fileNamed: "ClassroomScene01"){
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

// MARK: Animation for arrive
extension HallScene01{
    func animteArrive() {
        
        // Dissmis Pause
        self.dismissPause()
        
        // Lock player
        self.offsetCamera = -1
        self.playerNode?.playerCanWalk(false)
        self.playerNode?.alpha = 0
        
        // Left Wall
        let wallNode = self.childNode(withName: "background")?.childNode(withName: "leftWall") as? SKSpriteNode
        wallNode?.position.y += 900
        
        // Bus Node
        let busNode = SKSpriteNode(imageNamed: "bus")
        busNode.yScale = 1.2
        busNode.xScale = 1.2
        busNode.position = self.playerNode!.position
        busNode.position.x -= 400
        busNode.position.y += 10
        busNode.zPosition = playerNode!.zPosition + 10
        self.addChild(busNode)
        
        //Bus Arrive
        busNode.run(SKAction.moveTo(x: -1142.75, duration: 2)){
            self.playerNode!.alpha = 1
            print("EITA")
            busNode.run(SKAction.wait(forDuration: 0.5)){
                busNode.run(SKAction.moveTo(x: -1392.75, duration: 2))
                self.playerNode!.run(SKAction(named: "playerWalk")!)
                self.playerNode!.run(SKAction.moveBy(x: 320, y: 0, duration: 2.5)){
                    self.playerNode!.run(SKAction(named:"idle")!)
                    
                    // Devolver o collider
                    wallNode!.position.y -= 900
                    busNode.removeFromParent()
                    
                    self.ballon = DialogBallon(rootNode: Node(withText: "Felipe, Felipe\nFelipe, Felipe!", withChoices: []), referenceNode: self.childNode(withName: "anaOffTalk") as! SKSpriteNode, referenceScene: self)
                    
                    self.ballon?.action = {
                        self.ballon?.removeFromParent()
                        self.cinematicAna()
                    }
                    self.ballon?.setup()
                    self.ballon?.tailNode?.xScale *= -1
                    
                }
            }
        }
        
    }
    
    func cinematicAna() {
        let anaNode = SKSpriteNode(imageNamed: "anna_walk_000")
        anaNode.name = "anaNode"
        anaNode.size = CGSize(width: 87.4, height: 191.59)
        anaNode.xScale = -1
        anaNode.position = self.playerNode!.position
        anaNode.position.x += 400
        anaNode.zPosition = self.playerNode!.zPosition + 10
        self.addChild(anaNode)
        
        anaNode.run(SKAction(named: "anna_walk")!)
        anaNode.run(SKAction.moveTo(x: self.playerNode!.position.x + 100, duration: 1.5)){
            anaNode.size = CGSize(width: 38.64, height: 188.6)
            anaNode.run(SKAction(named: "anna_idle")!)
            self.ballon = DialogBallon(rootNode: hall01Root, referenceScene: self)
            self.ballon?.setup()
        }
        
        hall01d01.action = {
            anaNode.xScale *= -1
            anaNode.size = CGSize(width: 87.4, height: 191.59)
            anaNode.run(SKAction(named: "anna_walk")!)
            
            anaNode.run(SKAction.moveTo(x: self.playerNode!.position.x + 400, duration: 1.5)){
                print("CABOU")
                anaNode.removeFromParent()
                self.offsetCamera = 55
                self.ballon?.dismiss()
            }
        }
    }
}
