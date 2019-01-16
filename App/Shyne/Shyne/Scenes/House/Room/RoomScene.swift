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
    
    var pauseShowed = false
    
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
        
        
        self.playerNode!.playerCanWalk(false)
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
        
        room01c01PC.function = {
            PlayerModel.addKeys(k: "Desligar")
            self.ballon = DialogBallon.init(rootNode: room01d01c01PC, referenceScene: self)
            self.ballon!.setup()
        }
        room01c02PC.function = {
            PlayerModel.addKeys(k: "Email")
            self.ballon = DialogBallon.init(rootNode: room01d01c02PC, referenceScene: self)
            self.ballon!.setup()
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if !(pauseShowed){
            if(playerNode!.actualDirection == .left || playerNode!.actualDirection == .right){
                self.camera!.childNode(withName: "tutorial")?.run(SKAction.fadeOut(withDuration: 2)){
                    self.showPause()
                }
                
                pauseShowed = true
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
            
            if newName == "porta"{
                let cenaProxima:GKScene = GKScene(fileNamed: "HouseScene01")!
                if let nextScene = cenaProxima.rootNode as? HouseScene01{
                    nextScene.entities = cenaProxima.entities
                    ballon = DoorBallon(referenceNode: self.childNode(withName: newName) as! SKSpriteNode, referenceScene: self, nextScene: nextScene)
                }
                self.ballon?.setup()
            }else if(newName == "computer"){
                if(!(PlayerModel.getInstance().keys.contains("Email") || PlayerModel.getInstance().keys.contains("Desligar"))){
                    let node = self.childNode(withName: "trigger")?.childNode(withName: newName)?.childNode(withName: "\(newName)Talk") as! SKSpriteNode
                    
                    ballon = InteractionBallon(iconName: "icon_computer", referenceNode: node, referenceScene: self, action: {
                        self.ballon = DialogBallon.init(rootNode: room01PC, referenceNode: node, referenceScene: self)
                        self.ballon?.setup()
                    })
                    self.ballon?.setup()
                }
            }
            
            
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
        
        self.ballon = InteractionBallon(iconName: "", referenceNode: playerNode!, referenceScene: self) {
            self.ballon = DialogBallon.init(rootNode: room01Root, referenceScene: self)
            self.ballon!.setup()
        }
        self.ballon!.setup()
        
        self.preapreTutorial()
        
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

// MARK: Extesion to Tutorial
extension RoomScene{
    func preapreTutorial(){
        
        // Folder tutorial
        let tutorialNode = SKNode()
        tutorialNode.name = "tutorial"
        tutorialNode.position = .zero
        self.camera!.addChild(tutorialNode)
        
        // Black banner
        let bannerNode = SKSpriteNode(texture: nil, color: .black, size: self.size)
        tutorialNode.addChild(bannerNode)
        tutorialNode.zPosition = zPositionBannerTutorial
        tutorialNode.alpha = 0.7
        
        // Bring to front ballon
        self.ballon?.zPosition = tutorialNode.zPosition + 10
        
        // Explaning text
        let labelNode = SKLabelNode(text: NSLocalizedString("Este é um balão de interação\n\n  Clique nele para interagir", comment: ""))
        labelNode.numberOfLines = 4
        labelNode.fontSize = 80
        labelNode.fontName = "Futura"
        labelNode.position = CGPoint.zero
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        labelNode.zPosition = bannerNode.zPosition + 10
        tutorialNode.addChild(labelNode)
        
        // Action for ballon
        self.ballon!.action = {
            self.ballon = DialogBallon.init(rootNode: room01Root, referenceScene: self)
            self.ballon!.zPosition = tutorialNode.zPosition + 10
            self.ballon!.setup()
            
            labelNode.text = NSLocalizedString("Este é um balão de diálogo\n\n   Clique em qualquer lugar\n da tela para passar adiante", comment: "")
            
            self.ballon!.action = {
                
                self.ballon = DialogBallon.init(rootNode: room01d01, referenceScene: self)
                self.ballon!.setup()
                
                tutorialNode.alpha = 0
            }
        }
        
        room01d03.action = {
            tutorialNode.alpha = 0.7
            
            self.camera?.xScale = 0.35
            self.camera?.yScale = 0.35
            
            let choiceNodes = ChoicesBallon(choices: room01d03.choices, referenceScene: self)
            choiceNodes.setup()
            for ballon in choiceNodes.ballons{
                ballon.zPosition = tutorialNode.zPosition + 10
                
                ballon.action = {
                    self.ballon = DialogBallon(rootNode: room01d04, referenceScene: self)
                    self.ballon!.setup()
                    tutorialNode.alpha = 0
                }
               
                ballon.alpha = 0
            }
            
            choiceNodes.ballons[2].run(SKAction.wait(forDuration: 0.2)){
                choiceNodes.ballons[2].alpha = 1
            }
            choiceNodes.ballons[0].run(SKAction.wait(forDuration: 0.4)){
                choiceNodes.ballons[0].alpha = 1
            }
            choiceNodes.ballons[1].run(SKAction.wait(forDuration: 0.6)){
                choiceNodes.ballons[1].run(SKAction.fadeIn(withDuration: 0)){
                    labelNode.run(SKAction.fadeIn(withDuration: 0.5))
                }
            }
            
            labelNode.alpha = 0
            labelNode.text = NSLocalizedString("Estes são balões de escolha", comment: "")
            let auxTextNode = SKLabelNode(text: NSLocalizedString(" Lembre-se suas decisões\nafetam o rumo da estória", comment: ""))
            auxTextNode.numberOfLines = 4
            auxTextNode.fontSize = 65
            auxTextNode.fontName = "Futura"
            auxTextNode.position = CGPoint.zero
            auxTextNode.position.y -= (labelNode.frame.height + 50)
            auxTextNode.horizontalAlignmentMode = .center
            auxTextNode.verticalAlignmentMode = .center
            auxTextNode.zPosition = bannerNode.zPosition + 10
            labelNode.addChild(auxTextNode)
            labelNode.position.y += 250
        }
        
        room01d04.action = {
            
            if(self.playerNode?.actualDirection == .sit){
                self.playerNode?.run(SKAction(named: "felipe_standUp")!){
                    self.playerNode?.actualDirection = .idle
                    self.playerNode?.position.x += 10
                    labelNode.text = NSLocalizedString("        Clique na tela\npara movimentar o Felipe\n\n ⟵                             ⟶", comment: "")
                    labelNode.position = .zero
                    self.playerNode?.playerCanWalk(true)
                    self.ballon?.removeFromParent()
                }
            }else{
                self.playerNode?.actualDirection = .idle
            }
            
            tutorialNode.run(SKAction.wait(forDuration: 0.5)){
                bannerNode.alpha = 0
                tutorialNode.run(SKAction.fadeAlpha(to: 0.7, duration: 0.5))
                labelNode.removeAllChildren()
            }
            
            
            
            
            
        }
        
    }
}
