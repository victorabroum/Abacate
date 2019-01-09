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
    
    static let didLoadCompleteNotificationName = Notification.Name("com.abacates.hoddy.didLoadCompleteNotificationName")
    static let loadSaveGamecompleteNotificationName = Notification.Name("com.abacates.hoddy.loadSaveGamecompleteNotificationName")
    
    var entities = [GKEntity]()
    
    override func didMove(to view: SKView) {
        NotificationCenter.default.post(name: CustomSKSCene.didLoadCompleteNotificationName, object: nil)
        
        // TODO: Load Game here
        // Only call this notification if load return a valid valor
        NotificationCenter.default.post(name: CustomSKSCene.loadSaveGamecompleteNotificationName, object: nil)
    }
    
}
