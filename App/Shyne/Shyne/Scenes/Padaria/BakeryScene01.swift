//
//  BakeryScene01.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 21/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class BakeryScene01: CustomSKSCene, SKPhysicsContactDelegate {
    
    var padeiroNode: SKSpriteNode?
    
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {
        
        super.sceneDidLoad()
        
        self.padeiroNode = self.childNode(withName: "padeirocorpo") as? SKSpriteNode
        
        // Dizendo que a scene comanda o delegate
        physicsWorld.contactDelegate = self
        //Preparando a tree story dessa scene
        makeTreeOfRoomPadaria()
        self.prepareDialoge()
        
        PlayerModel.addKeys(k: "padeiro")
        
    }
    
    override func didMove(to view: SKView) {
       
        super.didMove(to: view)
        
        self.offsetCamera = -1
        
        // Prepare BG Music
        if let bga = self.childNode(withName: "bgAudios") {
            self.bgAudios = bga
            MusicHelper.startSounds(withAudios: bgAudios!.children, withVolume: 0.8)
        }
    }

    func didBegin(_ contact: SKPhysicsContact) {
        print("deu colisao")
        if let name=contact.bodyA.node?.name!{
            var newName:String {
                get {
                    return (name == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            if (PlayerModel.getInstance().keys.contains(newName)){
                if newName == "padeiro"{
                    
                    ballon = InteractionBallon(iconName: "", referenceNode: self.childNode(withName: "padeiroCaixa")! as! SKSpriteNode, referenceScene: self, action: {
                        self.ballon = DialogBallon.init(rootNode: rootNodePadaria, referenceNode: self.playerNode!, referenceScene: self)
                        self.ballon?.setup()
                    })
                    
                    
                    
                }else if newName == "porta"{
                    let cenaProxima:GKScene = GKScene(fileNamed: "CityScene01")!
                    if let nextScene = cenaProxima.rootNode as? CustomSKSCene{
                        
                        nextScene.playerNode!.position = (nextScene.childNode(withName: "initPosition")?.childNode(withName: "bakery")?.position)!
                        
                        nextScene.entities = cenaProxima.entities
                        
                        ballon = DoorBallon(referenceNode: self.playerNode!, referenceScene: self, nextScene: nextScene)
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
            
            if (PlayerModel.getInstance().keys.contains(newName)){
                ballon?.dismiss()
            }
        }
    }
    
    
    func prepareDialoge() {
        rootNodePadaria.action = {
            self.padeiroNode?.run(SKAction(named: "sweet_brad")!, completion: {
                self.ballon?.nextBallon()
            })
            
        }
        
        bakery01D4.action = {
            
            PlayerModel.addKeys(k: "porta")
            PlayerModel.addKeys(k: "houseDoor")
            
            // TODO: Remove padeiro keys from DAO
            
            self.ballon?.dismiss()
            self.padeiroNode?.texture = SKTexture(imageNamed: "idle_baker")
        }
        
        func justSair() {
            self.ballon?.removeFromParent()
            self.padeiroNode?.run(SKAction(named: "french_brad")!, completion: {
                
                self.ballon = DialogBallon.init(rootNode: bakery01D3, referenceNode: self.padeiroNode!, referenceScene: self)
                self.ballon?.setup()
            })
            
            PlayerModel.addKeys(k: "frenchBrad")
        }
        
        rVcErrou.function = {
            // Ele volta para pegar o pão francês
            justSair()
        }
        
        rVcErrouDeNovo.function = {
            // Ele volta para pegar o pão francês
            justSair()
        }
        
        rObrigado.function = {
            
            PlayerModel.addKeys(k: "porta")
            PlayerModel.addKeys(k: "houseDoor")
            PlayerModel.addKeys(k: "sweetBrad")
            
            self.ballon?.dismiss()
            
            // Sumi textura do pão
            self.padeiroNode?.texture = SKTexture(imageNamed: "idle_baker")
        }
        
    }
    
}
