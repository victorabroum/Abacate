//
//  RoomScene.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 18/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class RoomScene: CustomSKSCene,SKPhysicsContactDelegate {
    
    override func sceneDidLoad() {
        print("Room didLoad")
        super.sceneDidLoad()
        
        self.offsetCamera = -1
        
        physicsWorld.contactDelegate = self
        
        //Preparando a tree story dessa scene
        makeTreeOfRoom()
        
        // AddObserver for dismiss HomeScreen
        NotificationCenter.default.addObserver(self, selector: #selector(dismissHomeScreen), name: ButtonComponent.doneActionNotificationName, object: nil)
        
        // AddObserver for continue clicked
        NotificationCenter.default.addObserver(self, selector: #selector(contiueGame), name: ButtonComponent.continueGameNotificationName, object: nil)
        
        loadActionsOnDialog()
    }
    
    override func didMove(to view: SKView) {
        print("ROOM didMove")
        super.didMove(to: view)
        
        self.dismissPause()
        
        
        self.playerNode?.canWalk = false
        self.playerNode?.enterSitState()
        
        
        // TODO: Test if sceneName has somethig
        // Only call this notification if load return a valid valor
        if (PlayerModel.getInstance().sceneInformation.actualScenario == ""){
            print("Não tem ninguém")
            if let continueButtonNode = self.childNode(withName: "homeScreen")!.childNode(withName: "continueButton") as? SKSpriteNode{
                continueButtonNode.texture = SKTexture(imageNamed: "continueGameButton_cinza")
                continueButtonNode.isUserInteractionEnabled = false
            }
        }else{
            print("tem alguem")
            NotificationCenter.default.post(name: CustomSKSCene.loadSaveGamecompleteNotificationName, object: nil)
        }
        
        
        // Prepare BG Music
        if let bga = self.childNode(withName: "bgAudios") {
            print("BG AUDIOS")
            self.bgAudios = bga
            MusicHelper.startSounds(withAudios: bgAudios!.children, withVolume: 0.2)
        }
        
        room01d04.action = {
            
            if(self.playerNode?.actualDirection == .sit){
                self.playerNode?.run(SKAction(named: "felipe_standUp")!){
                    self.playerNode?.actualDirection = .idle
                    self.playerNode?.position.x += 10
                    self.ballon?.dismiss()
                }
            }else{
                self.playerNode?.actualDirection = .idle
                self.ballon?.dismiss()
            }
        
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if let name=contact.bodyA.node?.name!{
            var newName:String {
                get {
                    return (name == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            print("COLIDIU \(newName)")
          
            if newName == "porta"{
                let cenaProxima:GKScene = GKScene(fileNamed: "HouseScene01")!
                if let nextScene = cenaProxima.rootNode as? HouseScene01{
                    nextScene.entities = cenaProxima.entities
                    ballon = DoorBallon(referenceNode: self.childNode(withName: newName) as! SKSpriteNode, referenceScene: self, nextScene: nextScene)
                }
            }else if(newName == "computer"){
                let node = self.childNode(withName: "trigger")?.childNode(withName: newName)?.childNode(withName: "\(newName)Talk") as! SKSpriteNode
                
                ballon = InteractionBallon(iconName: "icon_computer", referenceNode: node, referenceScene: self, action: {
                    self.ballon = DialogBallon.init(rootNode: room01PC, referenceNode: node, referenceScene: self)
                    self.ballon?.setup()
                })
                
            }
            self.ballon?.setup()
            
        }
    }
    func didEnd(_ contact: SKPhysicsContact) {
        if let name=contact.bodyA.node?.name!{
            
            var newName:String {
                get {
                    return (name == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            ballon?.dismiss()
        }
    }
    
}

// MARK: Actions For dialogs
extension RoomScene {
    func loadActionsOnDialog() {
        room01c02PC.function = {
            
            // Chama a Scene dele no pc
            let onComputerNode = SKSpriteNode(imageNamed: "Email_Avocad")
            let constScale: CGFloat = 3
            onComputerNode.xScale = constScale
            onComputerNode.yScale = constScale
            onComputerNode.zPosition = 900
            
            onComputerNode.run(SKAction.fadeIn(withDuration: 0.5))
            
            self.camera!.addChild(onComputerNode)
            
            
            // MARK: Talk on Computer
//            let ballonNodeRef = SKSpriteNode(texture: nil, color: .red, size: CGSize(width: 10, height: 10))
//            ballonNodeRef.zPosition = onComputerNode.zPosition + 10
//            ballonNodeRef.position.x += 400
//            ballonNodeRef.position.y += 100
//            self.camera!.addChild(ballonNodeRef)
//
//            let ballonOnComputer = DialogBallon.init(rootNode: room01Root, referenceNode: ballonNodeRef, referenceScene: self)
//            ballonOnComputer.setup()
            
            onComputerNode.run(SKAction.wait(forDuration: 2)){
                onComputerNode.run(SKAction.fadeOut(withDuration: 0.5))
                self.ballon = DialogBallon.init(rootNode: room01d01c02PC, referenceNode: self.playerNode!, referenceScene: self)
                self.ballon?.setup()
                
            }
        }
    }
}

// MARK: Relationade to HomeScreen
extension RoomScene {
    @objc func dismissHomeScreen(){
        if let homeNode = self.childNode(withName: "homeScreen"){
            homeNode.run(SKAction.fadeOut(withDuration: 0.3))
        }
        self.offsetCamera = 45
        
        let startBallon = InteractionBallon(iconName: "", referenceNode: playerNode!, referenceScene: self) {
            self.ballon = DialogBallon.init(rootNode: room01Root, referenceScene: self)
            self.ballon!.setup()
        }
        startBallon.setup()
        
    }
    
    
    @objc func contiueGame() {
        let nameScene = PlayerModel.getInstance().sceneInformation.actualScenario
        let cenaProxima:GKScene = GKScene(fileNamed: "\(nameScene)")!
        if let nextScene = cenaProxima.rootNode as? CustomSKSCene{
            nextScene.entities = cenaProxima.entities
            let transition:SKTransition = SKTransition.fade(withDuration: 0.5)
            nextScene.scaleMode = SKSceneScaleMode.aspectFill
            self.view?.presentScene(nextScene, transition: transition)
        }
    }
    
}
