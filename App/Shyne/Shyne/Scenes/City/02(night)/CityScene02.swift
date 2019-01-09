//
//  CityScene02.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 21/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


class CityScene02: CustomSKSCene, SKPhysicsContactDelegate {

    var ballon: Ballon?
    
    override func sceneDidLoad() {
        
        super.sceneDidLoad()
        
        physicsWorld.contactDelegate = self
        
    }
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        
        self.playerNode?.prepareControl(withCamera: camera!, inScene: self, withCameraOffset: 120)
        
        // Prepare BG Music
        if let bga = self.childNode(withName: "bgAudios") {
            self.bgAudios = bga
            MusicHelper.startSounds(withAudios: bgAudios!.children, withVolume: 1.2)
        }
        
        self.animateBus()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyA.node?.name!{
            var novoNome:String {
                get {
                    return (nome == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            
            if novoNome == "porta"{
                let cenaProxima:GKScene = GKScene(fileNamed: "HouseScene03")!
                if let nextScene = cenaProxima.rootNode as? HouseScene03{
                    
                    nextScene.entities = cenaProxima.entities
                    self.ballon = DoorBallon(referenceNode: self.childNode(withName: "porta")! as! SKSpriteNode, referenceScene: self, nextScene: nextScene)
                }
            }
            
            self.ballon?.setup()
            
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyA.node?.name!{
            
            var novoNome:String {
                get {
                    return (nome == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            self.ballon?.dismiss()
        }
    }
    
    func animateBus(){
        self.playerNode?.playerCanWalk(false)
        self.playerNode?.alpha = 0
        
        
        let busNode = SKSpriteNode(imageNamed: "bus_flipped")
        busNode.position.x = self.frame.size.width + 100
        busNode.position.y = -83
        busNode.zPosition = playerZPosition + 100
        self.addChild(busNode)
        
        let arrive = SKAction.moveTo(x: (self.playerNode?.position.x)! - 20, duration: 2)
        let wait = SKAction.wait(forDuration: 0.5)
        let goWay = SKAction.move(by: CGVector(dx: -1000, dy: 0), duration: 2)
        let sequence = SKAction.sequence([arrive, wait])
        
        busNode.run(sequence) {
            self.playerNode?.alpha = 1
            busNode.run(goWay){
                busNode.alpha = 0
                self.playerNode?.playerCanWalk(true)
            }
        }
    }
}
