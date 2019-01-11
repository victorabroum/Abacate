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
    
    init(rootNode: Node, referenceNode: SKSpriteNode, referenceScene: SKScene){
        self.rootNode = rootNode
        self.referenceScene = referenceScene
        self.referenceNode = referenceNode
        
        if(rootNode.action != nil){
            self.action = rootNode.action
        }
        
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: 100, height: 100))
        
        // For is possible to click
        self.isUserInteractionEnabled = true
        self.zPosition = 500
        
        self.referenceNode.addChild(self)
    }
    
    init(rootNode: Node, referenceScene: SKScene, action: (()->Void)? = nil){
        self.rootNode = rootNode
        self.referenceScene = referenceScene
        if(rootNode.action != nil){
            self.action = rootNode.action
        }
        
        if let node = referenceScene.childNode(withName: rootNode.nodeToTalk) as? SKSpriteNode{
            self.referenceNode = node
        }else{
          self.referenceNode = SKSpriteNode()
        }
        
        
        
        
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
        
        if(self.action != nil){
            self.action!()
        }
        
        if(self.name != nil && self.name! == "choiceBallon"){
            print("REMOVE ALL")
            self.referenceNode.removeAllChildren()
        }
//
//        if(self.name == "choiceBallon"){
//            print("REMOVE ALL")
//            self.referenceNode.removeAllChildren()
//        }
        
        self.removeFromParent()
        
        
        
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
            
            
            self.dismiss()
        }
        
        
    }
    
    func dismiss(){
        self.removeFromParent()
        self.referenceNode.removeAllChildren()
        
        if let playerNode = self.referenceScene.childNode(withName: "playerNode") as? PlayerNode{
            playerNode.playerCanWalk(true)
        }
        
    }
    
    func setup(){
        
        //TODO: Animate this setup
        
        // Setup Ballon
        self.position = CGPoint(x: 0, y: 0)
        self.position.y += (self.size.height/2 - 30) + (referenceNode.size.height / 2)
        
        // Setup Label
        
        print("NODE TEXT \(rootNode.text)")
        
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
        
        if(self.referenceNode.xScale < 0){
            labelNode.xScale *= -1
            backgroundNode.xScale *= -1
//            pointBallon.xScale *= -1
        }
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
            
            auxNode.action = choice.function
            
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
            auxBallon.name = "choiceBallon"
            auxBallon.setup()
            auxBallon.position = CGPoint(x: -1 * (playerNode.size.width/2 + auxBallon.size.width/2), y: 0)
            
            
            // Setup BallonB
            auxBallon = ballons[1]
            auxBallon.name = "choiceBallon"
            auxBallon.setup()
            auxBallon.position = CGPoint(x: (playerNode.size.width/2 + auxBallon.size.width/2), y: 0)
            
            
            
            if ballons.count == 3 {
                auxBallon = ballons[2]
                auxBallon.name = "choiceBallon"
                auxBallon.setup()
                auxBallon.position = CGPoint(x: 0, y: (playerNode.size.height/2 + auxBallon.size.height/2))
                
            }
        }
        
    }
    
}

class InteractionBallon: Ballon{
    init(iconName: String, referenceNode: SKSpriteNode, referenceScene: SKScene, action: @escaping (() -> Void)){
        let auxNode = Node(withText: "", withChoices: [])
        super.init(rootNode: auxNode, referenceNode: referenceNode, referenceScene: referenceScene)
        self.iconName = iconName
        self.action = action
        self.referenceNode = referenceNode
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setup() {
        super.setup()
        
        if (iconName != ""){
            let iconNode = SKSpriteNode(imageNamed: iconName!)
            iconNode.zPosition = super.zPosition + 50
            iconNode.position = CGPoint.zero
            
            super.addChild(iconNode)
        }
        
    }
}

class DoorBallon : InteractionBallon{
    init(referenceNode: SKSpriteNode, referenceScene: SKScene, nextScene: SKScene){
        super.init(iconName: "Icone_Door", referenceNode: referenceNode, referenceScene: referenceScene) {
            
            //Auto-save
            let sceneInfo = SceneInformation.init(previousScenario: "\(referenceScene.name!)", actualScenario: "\(nextScene.name!)")
            PlayerModel.changeScene(scene: sceneInfo)
            PlayerModel.savePlayer()
            
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            nextScene.scaleMode = SKSceneScaleMode.aspectFill
            referenceScene.view?.presentScene(nextScene, transition: transition)

            
            
        }
        self.xScale = 1.2
        self.yScale = 1.2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class StairBallon: InteractionBallon{
    init(direction: String, playerNode: PlayerNode, referenceNode: SKSpriteNode, referenceScene: SKScene){
        
        super.init(iconName: "", referenceNode: referenceNode, referenceScene: referenceScene, action: {})
        
        if(direction == "goDown"){
            super.iconName = "iconDownstairs"
            super.action = {
                
                
                
                if (playerNode.xScale) <= 0{
                    playerNode.xScale *= -1
                }
                
                playerNode.makeMove(fromPosition:(self.referenceScene.childNode(withName:"referenceDown")?.position)!, toPosition: (self.referenceScene.childNode(withName: "referenceUp")?.position)!, withDuration: stairDuration)
                
                self.referenceScene.camera?.run(SKAction.moveTo(y: cameraDown, duration: stairDuration))
            }
        }else{
            
            super.iconName = "iconUpstairs"
            super.action = {
                
                
                
                if (playerNode.xScale) >= 0{
                    playerNode.xScale *= -1
                }
                
                
                playerNode.makeMove(fromPosition:(self.referenceScene.childNode(withName:"referenceUp")?.position)!, toPosition: (self.referenceScene.childNode(withName: "referenceDown")?.position)!, withDuration: stairDuration)
                
                self.referenceScene.camera?.run(SKAction.moveTo(y: cameraUpper, duration: stairDuration))
            }
            
        }
        
        self.xScale = 1.2
        self.yScale = 1.2
        
    }
    
    override func dismiss() {
        self.removeFromParent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DialogBallon: Ballon{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (self.action != nil){
            super.touchesBegan(touches, with: event)
        }else{
            nextBallon()
        }
        
    }
    
    override func setup() {
        if let playerNode = self.referenceScene.childNode(withName: "playerNode") as? PlayerNode{
            playerNode.playerCanWalk(false)
        }
        super.setup()
    }
}
