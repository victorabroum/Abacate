//
//  HouseScene02.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 21/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class HouseScene02: SKScene,SKPhysicsContactDelegate {
    var playerNode: PlayerNode?
    var dialogBox01: Dialogavel?
    
    var entities = [GKEntity]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {
        self.playerNode = childNode(withName: "playerNode") as? PlayerNode
        
        // Dizendo que a scene comanda o delegate
        physicsWorld.contactDelegate = self
        // Criando a box do diálogo
        self.dialogBox01 = Dialogavel(cena: self)
        //Preparando a tree story dessa scene
        house01makeTree()
        // Indicando a raiz da story
        self.dialogBox01!.indexNode = house01Root
    }
}
