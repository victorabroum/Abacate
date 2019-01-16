//
//  CityScene01.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 21/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class CityScene01: CustomSKSCene, SKPhysicsContactDelegate{
    
    var musicsNode: SKNode?
    override func sceneDidLoad() {
        
        super.sceneDidLoad()
        city01MakeTree()
        porta01.action = {
            porta01Root = porta02
            self.ballon?.dismiss()
        }
        porta02.action = {
            porta01Root = porta03
            self.ballon?.dismiss()
        }
        porta03.action = {
            porta01Root = porta01
            self.ballon?.dismiss()
        }
        
        if let musicNode = self.childNode(withName: "musics") {
            self.musicsNode = musicNode
        }
        
        physicsWorld.contactDelegate = self
        
        if let people = self.childNode(withName: "people"){
            self.animatePeople(inNodes: people.children)
        }
        
    }
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        
        self.offsetCamera = 100
        
        MusicPanHelper.prepareForPan(thisScne: self, forThisListner: self.playerNode!, fromThisMusics: (self.musicsNode?.children)!)
        
        // Prepare BG Music
        if let bga = self.childNode(withName: "bgAudios") {
            self.bgAudios = bga
            MusicHelper.startSounds(withAudios: bgAudios!.children, withVolume: 1.2)
        }
        
        self.correctPlayerNodePosition()
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        MusicPanHelper.updateMusicPan(inSpace: self.frame.size, forThisListner: self.playerNode!, fromThisMusicNodes: (self.musicsNode?.children)!)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let name=contact.bodyA.node?.name!{
            var newName:String {
                get {
                    return (name == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            if(PlayerModel.getInstance().keys.contains(newName)){
                
                if newName == "bakeryDoor"{
                    
                    let cenaProxima:GKScene = GKScene(fileNamed: "BakeryScene01")!
                    if let nextScene = cenaProxima.rootNode as? BakeryScene01{
                        
                        
                        
                        nextScene.entities = cenaProxima.entities
                        let trigger = self.childNode(withName: "trigger")?.childNode(withName: newName)!
                        
                        ballon = DoorBallon(referenceNode: trigger as! SKSpriteNode, referenceScene: self, nextScene: nextScene) 
                        
                    }
                    
                }
                
                if newName == "xandy"{
                    let trigger = self.childNode(withName: "trigger")?.childNode(withName: newName)!
                    self.ballon = InteractionBallon(iconName: "", referenceNode: trigger as! SKSpriteNode, referenceScene: self){
                        self.ballon = DialogBallon(rootNode: violeiro01Root, referenceNode: self.playerNode!, referenceScene: self)
                        self.ballon?.setup()
                    }
                }
                
                if newName == "velha"{
                    let trigger = self.childNode(withName: "trigger")?.childNode(withName: newName)!
                    self.ballon = InteractionBallon(iconName: "", referenceNode: trigger as! SKSpriteNode, referenceScene: self){
                        self.ballon = DialogBallon(rootNode: old01Root, referenceNode: self.childNode(withName: old01Root.nodeToTalk) as! SKSpriteNode, referenceScene: self)
                        self.ballon?.setup()
                    }
                }
                if newName == "caraChato"{
                    let trigger = self.childNode(withName: "trigger")?.childNode(withName: newName)!
                    self.ballon = InteractionBallon(iconName: "", referenceNode: trigger as! SKSpriteNode, referenceScene: self){
                        self.ballon = DialogBallon(rootNode: porta01Root, referenceNode: self.childNode(withName: porta01Root.nodeToTalk) as! SKSpriteNode, referenceScene: self)
                        self.ballon?.setup()
                    }
                }
                
                if(newName == "busStop"){
                    // Rola a animação do bus e depois vai para a sala de aula
                    
                    // Go to Classroom
                    if let cenaProxima: GKScene = GKScene(fileNamed: "HallScene01"){
                        if let nextScene = cenaProxima.rootNode as? CustomSKSCene{
                            
                            nextScene.entities = cenaProxima.entities
                            let trigger = self.childNode(withName: "trigger")?.childNode(withName: newName)!
                            
                            ballon = InteractionBallon(iconName: "", referenceNode: trigger as! SKSpriteNode, referenceScene: self, action: {
                                self.busAnimate(nextScene)
                            })
                            
                        }
                    }
                    
                }
                
                if(newName == "houseDoor"){
                    // Go to House 02
                    if let cenaProxima: GKScene = GKScene(fileNamed: "HouseScene02"){
                        if let nextScene = cenaProxima.rootNode as? HouseScene02{
                            
                            nextScene.entities = cenaProxima.entities
                            let trigger = self.childNode(withName: "trigger")?.childNode(withName: newName)!
                            
                            ballon = DoorBallon(referenceNode: trigger as! SKSpriteNode, referenceScene: self, nextScene: nextScene)
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
    
    
    func busAnimate(_ nextScene: SKScene) {
        self.dismissPause()
        self.playerNode?.playerCanWalk(false)
        let busNode = SKSpriteNode(imageNamed: "bus")
        busNode.position.x = self.playerNode!.position.x - 800
        busNode.position.y = -83
        busNode.zPosition = playerZPosition + 100
        self.addChild(busNode)
        
        let arrive = SKAction.moveTo(x: (self.playerNode?.position.x)! - 20, duration: 3)
        let wait = SKAction.wait(forDuration: 0.5)
        let goWay = SKAction.move(by: CGVector(dx: 700, dy: 0), duration: 2)
        let sequence = SKAction.sequence([arrive, wait])
        
        
        busNode.run(sequence, completion: {
            // Troca de cena
            self.playerNode?.alpha = 0
            busNode.run(goWay, completion: {
                
                let sceneInfo = SceneInformation.init(previousScenario: "CityScene01", actualScenario: "HallScene01")
                PlayerModel.changeScene(scene: sceneInfo)
                PlayerModel.savePlayer()
                
                let transition:SKTransition = SKTransition.fade(withDuration: 0.5)
                nextScene.scaleMode = SKSceneScaleMode.aspectFill
                self.view?.presentScene(nextScene, transition: transition)
            })
        })
    }
    
    func animatePeople(inNodes nodes:[SKNode]){
        for node in nodes{
            print("name \(node.name!)")
            node.run(SKAction.init(named: node.name!)!)
        }
    }
    
    func correctPlayerNodePosition() {
        
        if(PlayerModel.getInstance().sceneInformation.previousScenario == "BakeryScene01"){
            self.playerNode!.position = (self.childNode(withName: "initPosition")!.childNode(withName: "bakery")?.position)!
            self.camera?.position.x = -1979.577
        }else if (PlayerModel.getInstance().sceneInformation.previousScenario == "HouseScene01" || PlayerModel.getInstance().sceneInformation.previousScenario == "HouseScene02"){
            self.playerNode?.position = (self.childNode(withName: "initPosition")?.childNode(withName: "house")?.position)!
            self.camera?.position.x = -273.8
        }
    }
    
}
