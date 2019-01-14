//
//  CustomSKScene.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 08/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit

class CustomSKSCene: SKScene{
    
    static let didMoveCompleteNotificationName = Notification.Name("com.abacates.hoddy.didMoveCompleteNotificationName")
    static let loadSaveGamecompleteNotificationName = Notification.Name("com.abacates.hoddy.loadSaveGamecompleteNotificationName")
    
    var entities = [GKEntity]()
    var playerNode: PlayerNode?
    
    // To control BG Audios
    var bgAudios: SKNode?
    
    // Ballon Structures
    var ballon: Ballon?
    
    var offsetCamera: CGFloat = 30
    
    override func sceneDidLoad() {
        // Get PlayerNode reference
        
        if let node = self.childNode(withName: "playerNode") as? PlayerNode{
            playerNode = node
        }
        
        
        
    }
    
    override func didMove(to view: SKView) {
        
        self.preparePause()
        
        // Prepare Player for walk
        if(playerNode != nil){
            playerNode?.prepareControl(withCamera: camera!, inScene: self, withCameraOffset: -1)
        }
        
        
        NotificationCenter.default.post(name: CustomSKSCene.didMoveCompleteNotificationName, object: nil)
        
        // TODO: Test if sceneName has somethig
        // Only call this notification if load return a valid valor
        if (PlayerModel.getInstance().sceneInformation.actualScenario == ""){
            print("Não tem ninguém")
        }else{
            print("tem alguem")
            NotificationCenter.default.post(name: CustomSKSCene.loadSaveGamecompleteNotificationName, object: nil)
        }
        
        
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if(playerNode != nil){
            self.playerNode?.makePlayerWalk()
            
            if !(offsetCamera == -1){
                let positionCamera = CGPoint(x: (self.playerNode?.position.x)!, y: (self.playerNode?.position.y)! + offsetCamera)
                self.camera?.run(SKAction.move(to: positionCamera, duration: 0.6))
            }
        }
    }
    
    override func willMove(from view: SKView) {
        if self.bgAudios != nil{
            MusicHelper.stopSounds(withAudios: self.bgAudios!.children)
        }
    }
    
    func preparePause() {
        
        print("PREAPRE PAUSE")
        
        // Subir HUD de Pause
        let backgroundSize = self.size
        let backgroundPause = SKSpriteNode(imageNamed: "Pause")
        backgroundPause.position = CGPoint(x: 0, y: -(backgroundSize.height * 2))
        let constScaleBg: CGFloat = 3.1
        backgroundPause.zPosition = 600
        backgroundPause.xScale = constScaleBg
        backgroundPause.yScale = constScaleBg
        self.camera!.addChild(backgroundPause)
        
        // Button Continuar
        let btContinueNode = ActionSpriteNode(imageNamed: "continueButton") {
            self.playerNode!.playerCanWalk(true)
            self.playerNode!.exitPauseState()
            backgroundPause.run(SKAction.move(to: CGPoint(x: 0, y: -(backgroundSize.height * 2)), duration: 1))
        }
        btContinueNode.isUserInteractionEnabled = true
        btContinueNode.zPosition = backgroundPause.zPosition + 100
        btContinueNode.position = CGPoint(x: 0, y: 50)
        backgroundPause.addChild(btContinueNode)
        
        let btMenu = ActionSpriteNode(imageNamed: "menuButton"){
            
            let cenaProxima:GKScene = GKScene(fileNamed: "RoomScene")!
            if let nextScene = cenaProxima.rootNode as? CustomSKSCene{
                nextScene.entities = cenaProxima.entities
                
                let transition:SKTransition = SKTransition.fade(withDuration: 1)
                nextScene.scaleMode = SKSceneScaleMode.aspectFill
                self.view?.presentScene(nextScene, transition: transition)
            }
        }
        btMenu.isUserInteractionEnabled = true
        btMenu.zPosition = backgroundPause.zPosition + 100
        btMenu.position = CGPoint(x: 0, y: -24)
        backgroundPause.addChild(btMenu)
        
        
        
        // Add icon of Pause
        let pauseNode = ActionSpriteNode(imageNamed: "pauseButton") {
            
            
            if(self.playerNode!.canWalk){
                self.playerNode!.playerCanWalk(false)
                self.playerNode?.actualDirection = .paused
                self.playerNode?.enterPausedState()
                backgroundPause.run(SKAction.wait(forDuration: 0.8)){
                    backgroundPause.run(SKAction.move(to: CGPoint(x: 0, y: 0), duration: 1))
                }
            }else{
                self.playerNode!.playerCanWalk(true)
                self.playerNode!.exitPauseState()
                backgroundPause.run(SKAction.move(to: CGPoint(x: 0, y: -(backgroundSize.height * 2)), duration: 1))
            }
            
            
            
        }
        pauseNode.name = "pauseNode"
        pauseNode.isUserInteractionEnabled = true
        pauseNode.zPosition = 900
        let constScale: CGFloat = 2.5
        pauseNode.xScale = constScale
        pauseNode.yScale = constScale
        pauseNode.position = CGPoint(x: backgroundSize.width / 2.5, y: backgroundSize.height / 2.8)
        self.camera?.addChild(pauseNode)
        
    }
    
    func dismissPause() {
        var pauseIconNode: SKSpriteNode?
        
        for child in self.camera!.children{
            
            if(child.name != nil && child.name! == "pauseNode"){
                pauseIconNode = child as? SKSpriteNode
            }
        }
        
        if(pauseIconNode != nil){
            pauseIconNode!.run(SKAction.fadeOut(withDuration: 0.3))
        }
        
    }
    
    func showPause(){
        var pauseIconNode: SKSpriteNode?
        for child in self.camera!.children{
            if(child.name != nil && child.name! == "pauseNode"){
                pauseIconNode = child as? SKSpriteNode
            }
        }
        if(pauseIconNode != nil){
            pauseIconNode!.run(SKAction.fadeIn(withDuration: 0.3))
        }
    }
    
}
