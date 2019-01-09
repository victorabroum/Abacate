//
//  ButtonLayoutComponent.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 09/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class ButtonLayoutComponent: GKComponent {
    
    var node: SKNode?
    
    init(withText text: String, onNode node: SKNode){
        super.init()
        self.setup(withText: text, onNode: node)
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(withText text: String, onNode node: SKNode){
        
        self.node = node
        
        // Setup label
        let labelNode = SKLabelNode(text: "\(text)")
        labelNode.fontSize = 22
        labelNode.fontName = "Futura"
        labelNode.position = CGPoint.zero
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        labelNode.fontColor = .black
        labelNode.zPosition = node.zPosition + 50
        node.addChild(labelNode)
        
        // Ajust ballon size
        if let aux = node as? SKSpriteNode{
            aux.size.width = (1.5 * labelNode.frame.size.width)
        }
        
        if(node.entity?.component(ofType: ContinueGameComponent.self) != nil){
            print("é o continuew")
            self.disable()
            NotificationCenter.default.addObserver(self, selector: #selector(enable), name: CustomSKSCene.loadSaveGamecompleteNotificationName, object: nil)
            
        }
        
    }
    
    @objc func disable() {
        if(self.node != nil){
            self.node!.alpha = 0.5
            self.node!.isUserInteractionEnabled = false
        }
        
    }
    
    @objc func enable(){
        if(self.node != nil){
            self.node!.alpha = 1
            self.node!.isUserInteractionEnabled = true
        }
    }
    
}
