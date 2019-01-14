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
    case choice1
    case choice2
    case choice3
    case interaction
}

class Ballon : SKSpriteNode{
    var referenceNode: SKSpriteNode
    var iconName: String?
    var action: (()->Void)?
    var rootNode: Node
    var referenceScene: CustomSKSCene
    var feel: Feel?
    
    var tailNode: SKSpriteNode?
    
    required init?(coder aDecoder: NSCoder) {
        self.referenceNode = SKSpriteNode(coder: aDecoder)!
        self.iconName = ""
        self.rootNode = Node(withText: "VAZIO", withChoices: [])
        self.referenceScene = SKScene(coder: aDecoder)! as! CustomSKSCene
        super.init(coder: aDecoder)
    }
    
    init(rootNode: Node, referenceNode: SKSpriteNode, referenceScene: CustomSKSCene){
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
    
    init(rootNode: Node, referenceScene: CustomSKSCene,feel: Feel = Feel(happy: 0, normal: 0, shy: 0), action: (()->Void)? = nil){
        self.rootNode = rootNode
        self.referenceScene = referenceScene
        self.feel = feel
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
            
            for child in self.referenceNode.children{
                if(child.name == "choiceBallon"){
                    child.removeFromParent()
                }
            }
        }
        
        self.removeFromParent()
        
    }
    
    func nextBallon() {
        self.removeFromParent()
        if(self.name != nil && self.name! == "choiceBallon"){
            for child in self.referenceNode.children{
                if(child.name == "choiceBallon"){
                    child.removeFromParent()
                }
            }
        }
        
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
        if(self.name != nil && self.name! == "choiceBallon"){
            for child in self.referenceNode.children{
                if(child.name == "choiceBallon"){
                    child.removeFromParent()
                }
            }
        }
        
        if let playerNode = self.referenceScene.childNode(withName: "playerNode") as? PlayerNode{
            playerNode.playerCanWalk(true)
        }
        
        self.referenceScene.showPause()
        
    }
    
    func setup(){
        
        //TODO: Animate this setup
        
        // Dismiss Pause
        if !(self is InteractionBallon){
            self.referenceScene.dismissPause()
        }
        
        
        // Setup Ballon
        self.position = CGPoint(x: 0, y: 0)
        self.position.y += (self.size.height/2 - 15) + (referenceNode.size.height / 2)
        
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
        var backgroundName = ""
        switch rootNode.typeBallon {
        case .speak:
            backgroundName = "dialogueBox"
        case .thought:
            backgroundName = "thinkBox"
        case .choice1:
            backgroundName = "choiceBox1"
        case .choice2:
            backgroundName = "choiceBox2"
        case .choice3:
            backgroundName = "choiceBox3"
        default:
            backgroundName = "dialogueBox"
        }
        
        let backgroundNode = SKSpriteNode(imageNamed: backgroundName)
        backgroundNode.size.width = labelNode.frame.size.width + 30
        backgroundNode.size.height = labelNode.frame.size.height + 35
        backgroundNode.position = CGPoint.zero
        backgroundNode.zPosition = self.zPosition + 25
        
        self.addChild(backgroundNode)
        
        
            
        // Setup point of ballon
        let pointBallon = SKSpriteNode(imageNamed: "\(backgroundName)_tail")
        pointBallon.zPosition = backgroundNode.zPosition - 300
        self.tailNode = pointBallon
        self.addChild(pointBallon)
        pointBallon.position = CGPoint.zero
        pointBallon.position.x += backgroundNode.size.width / 4
        
        if(iconName != nil && iconName != ""){
            if let node = self.childNode(withName: "\(iconName!)") as? SKSpriteNode{
                pointBallon.position.y -= node.size.height / 2
                pointBallon.size = CGSize(width: node.size.width/4, height: node.size.height/3)
            }
        }else{
            pointBallon.position.y -= backgroundNode.size.height / 2
            pointBallon.size = CGSize(width: backgroundNode.size.width/4, height: backgroundNode.size.height/3)
        }
        
        
        
        if(self.referenceNode.xScale < 0){
            labelNode.xScale *= -1
            backgroundNode.xScale *= -1
            pointBallon.xScale *= -1
        }else{
            pointBallon.xScale *= -1
        }
    }
}


class ChoicesBallon : SKSpriteNode{
    var ballons: [Ballon] = []
    var referenceScene: CustomSKSCene
    
    init(choices: [Answer], referenceScene: CustomSKSCene){
        self.referenceScene = referenceScene
        for choice in choices{
            let auxNode = Node(withText: choice.text, withChoices: [])
            if !choice.child.isEmpty {
                auxNode.add(child: choice.child.first!)
            }
            
            auxNode.action = choice.function
            
            ballons.append(DialogBallon(rootNode: auxNode, referenceScene: self.referenceScene, feel: choice.amount))
            
            
        }
        
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: 100, height: 100))
//        self.isUserInteractionEnabled = true
        self.name = "choicesBallon"
        self.referenceScene.addChild(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.referenceScene = SKScene(coder: aDecoder)! as! CustomSKSCene
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
            auxBallon.rootNode.typeBallon = .choice1
            auxBallon.name = "choiceBallon"
            auxBallon.setup()
            auxBallon.position = CGPoint(x: -1 * (playerNode.size.width/2 + auxBallon.size.width/2), y: 0)
            if(auxBallon.tailNode != nil){
                auxBallon.tailNode?.xScale *= -1
            }
            
            
            
            // Setup BallonB
            auxBallon = ballons[1]
            auxBallon.rootNode.typeBallon = .choice2
            auxBallon.name = "choiceBallon"
            auxBallon.setup()
            auxBallon.position = CGPoint(x: (playerNode.size.width/2 + auxBallon.size.width/2), y: 0)
            
            
            
            
            if ballons.count == 3 {
                auxBallon = ballons[2]
                auxBallon.rootNode.typeBallon = .choice3
                auxBallon.name = "choiceBallon"
                auxBallon.setup()
                auxBallon.position = CGPoint(x: 0, y: (playerNode.size.height/2 + auxBallon.size.height/2))
                
            }
        }
        
    }
    
}

class InteractionBallon: Ballon{
    init(iconName: String, referenceNode: SKSpriteNode, referenceScene: CustomSKSCene, action: @escaping (() -> Void)){
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
        if (iconName != ""){
            let iconNode = SKSpriteNode(imageNamed: iconName!)
            iconNode.name = iconName
            iconNode.zPosition = super.zPosition + 50
            iconNode.position = CGPoint.zero
            
            super.addChild(iconNode)
        }
        super.setup()
        
    }
}

class DoorBallon : InteractionBallon{
    init(referenceNode: SKSpriteNode, referenceScene: SKScene, nextScene: SKScene){
        super.init(iconName: "Icone_Door", referenceNode: referenceNode, referenceScene: referenceScene as! CustomSKSCene) {
            
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
    init(direction: String, playerNode: PlayerNode, referenceNode: SKSpriteNode, referenceScene: CustomSKSCene){
        
        super.init(iconName: "", referenceNode: referenceNode, referenceScene: referenceScene, action: {})
        
        if(direction == "goDown"){
            super.iconName = "iconDownstairs"
            super.action = {
                
                if (playerNode.xScale) <= 0{
                    playerNode.xScale *= -1
                }
                
                playerNode.makeMove(fromPosition:(self.referenceScene.childNode(withName:"referenceDown")?.position)!, toPosition: (self.referenceScene.childNode(withName: "referenceUp")?.position)!, withDuration: stairDuration)
                
                self.referenceScene.camera?.run(SKAction.moveTo(y: cameraDown, duration: stairDuration)){
                    referenceScene.offsetCamera = 80
                    self.referenceScene.showPause()
                }
            }
        }else{
            
            super.iconName = "iconUpstairs"
            super.action = {
                
                
                
                if (playerNode.xScale) >= 0{
                    playerNode.xScale *= -1
                }
                
                
                playerNode.makeMove(fromPosition:(self.referenceScene.childNode(withName:"referenceUp")?.position)!, toPosition: (self.referenceScene.childNode(withName: "referenceDown")?.position)!, withDuration: stairDuration)
                
                self.referenceScene.camera?.run(SKAction.moveTo(y: cameraUpper, duration: stairDuration)){
                    referenceScene.offsetCamera = 35
                    self.referenceScene.showPause()
                }
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.referenceScene.dismissPause()
    }
}

class DialogBallon: Ballon{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        PlayerModel.incrementStatusBom(feel?.happy ?? 0)
        PlayerModel.incrementStatusMedio(feel?.normal ?? 0)
        PlayerModel.incrementStatusRuim(feel?.shy ?? 0)
        print("-------------------------------------------------")
        print("Bom:\(PlayerModel.getInstance().status.bom)\n")
        print("Medio:\(PlayerModel.getInstance().status.medio)\n")
        print("Ruim:\(PlayerModel.getInstance().status.ruim)\n")
        print("-------------------------------------------------")
        
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
