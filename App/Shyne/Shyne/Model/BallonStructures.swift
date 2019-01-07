//
//  BallonStructures.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 07/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation
import SpriteKit

enum TypeBallon {
    case speak
    case thought
    case choices
    case interaction
}

class Ballon : SKSpriteNode{
    var referenceNode: SKSpriteNode
    var iconName: String?
    var action: (()->Void)?
    var rootNode: Node
    var referenceScene: SKScene
    
    required init?(coder aDecoder: NSCoder) {
        self.referenceNode = SKSpriteNode(coder: aDecoder)!
        self.iconName = ""
        self.rootNode = Node(withText: "VAZIO", withChoices: [])
        self.referenceScene = SKScene(coder: aDecoder)!
        super.init(coder: aDecoder)
    }
    
    init(rootNode: Node, referenceScene: SKScene){
        self.rootNode = rootNode
        self.referenceScene = referenceScene
        self.referenceNode = self.referenceScene.childNode(withName: rootNode.nodeToTalk) as! SKSpriteNode
        
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: 100, height: 100))
        
        // For is possible to click
        self.isUserInteractionEnabled = true
        self.zPosition = 500
        
        self.referenceNode.addChild(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Resposta háptica
        let notification = UINotificationFeedbackGenerator()
        notification.notificationOccurred(.success)

    }
    
    func nextBallon() {
        
        self.removeFromParent()
        self.referenceNode.removeAllChildren()
        
        if(self.rootNode.childrens.count != 0){
            
            let newDialogBallon = DialogBallon(rootNode: self.rootNode.childrens.first!, referenceScene: self.referenceScene)
            newDialogBallon.setup()
            
        }else if(self.rootNode.choices.count != 0){
            let choicesBallon = ChoicesBallon(choices: self.rootNode.choices, referenceScene: self.referenceScene)
            choicesBallon.setup()
        }else{
            if let playerNode = self.referenceScene.childNode(withName: "playerNode") as? PlayerNode{
                playerNode.playerCanWalk(true)
            }
        }
    }
    
    func setup(){
        
        if let playerNode = self.referenceScene.childNode(withName: "playerNode") as? PlayerNode{
            playerNode.playerCanWalk(false)
        }
        
        //TODO: Animate this setup
        
        // Setup Ballon
        self.position = CGPoint(x: 0, y: 0)
        self.position.y += (self.size.height/2) + (referenceNode.size.height / 2)
        
        // Setup Label
        let labelNode = SKLabelNode(text: rootNode.text)
        labelNode.numberOfLines = 4
        labelNode.fontSize = 18
        labelNode.fontName = "Futura"
        labelNode.position = CGPoint.zero
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        labelNode.fontColor = .black
        labelNode.zPosition = self.zPosition + 50
        
        self.addChild(labelNode)
        
        // Setup Bakcground
        // TODO: Mudar a textura
        var backgroundName = ""
        switch rootNode.typeBallon {
        case .speak:
            backgroundName = "dialogue_box_top"
        case .thought:
            backgroundName = "tought_box"
        default:
            backgroundName = "dialogue_box_top"
        }
        let backgroundNode = SKSpriteNode(imageNamed: backgroundName)
            
        backgroundNode.size.width = labelNode.frame.size.width + 20
        backgroundNode.size.height = labelNode.frame.size.height + 20
        backgroundNode.position = CGPoint.zero
        backgroundNode.zPosition = self.zPosition + 25
        
        self.addChild(backgroundNode)
            
        // Setup point of ballon
        // TODO: Mudar a textura
//        let pointBallon = SKSpriteNode(imageNamed: "pointBallon")
//        backgroundNode.anchorPoint = CGPoint(x: 0.5, y: 0)
//        pointBallon.position = CGPoint.zero
//        pointBallon.zPosition = backgroundNode.zPosition - 3
//        backgroundNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        self.addChild(pointBallon)
        
    }
}


class ChoicesBallon : SKSpriteNode{
    var ballons: [Ballon] = []
    var referenceScene: SKScene
    
    init(choices: [Answer], referenceScene: SKScene){
        self.referenceScene = referenceScene
        for choice in choices{
            let auxNode = Node(withText: choice.text, withChoices: [])
            if !choice.child.isEmpty {
                auxNode.add(child: choice.child.first!)
            }
            
            ballons.append(DialogBallon(rootNode: auxNode, referenceScene: self.referenceScene))
            
        }
        
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: 100, height: 100))
//        self.isUserInteractionEnabled = true
        self.name = "choicesBallon"
        self.referenceScene.addChild(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.referenceScene = SKScene(coder: aDecoder)!
        super.init(coder: aDecoder)
    }
    
    func dismiss() {
        for choice in self.ballons {
            choice.removeFromParent()
        }
    }
    
    
    func setup(){
        
        // Get Player reference on Scene
        if let playerNode = self.referenceScene.childNode(withName: "playerNode") as? SKSpriteNode{
            
            
            
            var auxBallon = ballons[0]
            // Setup BallonA
            auxBallon.setup()
            auxBallon.position = CGPoint(x: -1 * (playerNode.size.width/2 + auxBallon.size.width/2), y: 0)
            
            
            // Setup BallonB
            auxBallon = ballons[1]
            auxBallon.setup()
            auxBallon.position = CGPoint(x: (playerNode.size.width/2 + auxBallon.size.width/2), y: 0)
            
            
            
            if ballons.count == 3 {
                auxBallon = ballons[2]
                auxBallon.setup()
                auxBallon.position = CGPoint(x: 0, y: (playerNode.size.height/2 + auxBallon.size.height/2))
                
            }
        }
        
    }
    
}

class InteractionBallon: Ballon{
    init(iconName: String, referenceScene: SKScene, action: @escaping (() -> Void)){
        super.init(rootNode: Node(withText: "", withChoices: []), referenceScene: referenceScene)
        self.iconName = iconName
        self.action = action
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Execute Action
        
        super.touchesBegan(touches, with: event)
        
        print("EXECUTE ACTION")
        self.action!()
        
        self.removeFromParent()
    }
    
    override func setup() {
        super.setup()
        
        let iconNode = SKSpriteNode(imageNamed: iconName!)
        iconNode.zPosition = super.zPosition + 50
        iconNode.position = CGPoint.zero
        
        super.addChild(iconNode)
    }
}

class DialogBallon: Ballon{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("CLICOU NO MALUCO")
        nextBallon()
    }
}
