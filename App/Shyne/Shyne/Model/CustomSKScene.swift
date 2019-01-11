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
    
}
