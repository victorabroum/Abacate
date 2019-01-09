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
    
    override func didMove(to view: SKView) {
        
        // Get PlayerNode reference
        playerNode = self.childNode(withName: "playerNode" ) as? PlayerNode
        
        NotificationCenter.default.post(name: CustomSKSCene.didMoveCompleteNotificationName, object: nil)
        
        // TODO: Load Game here
        // Only call this notification if load return a valid valor
        if (PlayerModel.getInstance().keys.count <= 0){
            print("Não tem ninguém")
        }else{
            print("tem alguem")
            NotificationCenter.default.post(name: CustomSKSCene.loadSaveGamecompleteNotificationName, object: nil)
        }
    }
    
}
