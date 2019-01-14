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

class HouseScene02: CustomSKSCene,SKPhysicsContactDelegate {
    
    var house02Root: Node = Node(withText: "", withChoices: [])
    private var lastUpdateTime : TimeInterval = 0
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        // Dizendo que a scene comanda o delegate
        physicsWorld.contactDelegate = self
        // Criando a box do diálogo
        //Preparando a tree story dessa scene
        house02makeTree()
        // Indicando a raiz da story
        
        if(PlayerModel.getInstance().keys.contains("sweetBrad")){
            self.house02Root = house02RootDoce
        }else if (PlayerModel.getInstance().keys.contains("frenchBrad")){
            self.house02Root = house02RootNormal
        }else{
            self.house02Root = house02Root3
        }
        
        self.prepareDialog()
       
    }
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.offsetCamera = 75
        
        PlayerModel.addKeys(k: "dady")
        PlayerModel.addKeys(k: "goUp")
        PlayerModel.addKeys(k: "goDown")
        PlayerModel.addKeys(k: "dadDoor")
        
        // Prepare BG Music
        if let bga = self.childNode(withName: "bgAudios") {
            self.bgAudios = bga
            MusicHelper.startSounds(withAudios: bgAudios!.children, withVolume: 0.2)
        }

    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let name=contact.bodyA.node?.name!{
            var newName:String {
                get {
                    return (name == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            if(PlayerModel.getInstance().keys.contains(newName)){
                
                    if newName == "dady"{
                        
                        self.ballon = InteractionBallon(iconName: "", referenceNode: self.childNode(withName: "dady")! as! SKSpriteNode, referenceScene: self, action: {
                            let newBallon = DialogBallon.init(rootNode: self.house02Root, referenceScene: self)
                            newBallon.setup()
                        })
                        
                    }else if(newName == "goUp"){
                        
                        ballon = StairBallon(direction: "goUp", playerNode: self.playerNode!, referenceNode: self.childNode(withName: newName)! as! SKSpriteNode, referenceScene: self)
                        
                    }else if(newName == "goDown"){
                        
                        ballon = StairBallon(direction: "goDown", playerNode: self.playerNode!, referenceNode: self.childNode(withName: newName)! as! SKSpriteNode, referenceScene: self)
                        
                    }else if newName == "porta"{
                        let cenaProxima:GKScene = GKScene(fileNamed: "CityScene01")!
                        if let nextScene = cenaProxima.rootNode as? CityScene01{
                            
                            nextScene.entities = cenaProxima.entities
                            self.ballon = DoorBallon(referenceNode: self.childNode(withName: "popupDoor")! as! SKSpriteNode, referenceScene: self, nextScene: nextScene)
                            
                        }
                    }else if(newName == "dadDoor"){
                        ballon = InteractionBallon(iconName: "Icone_Locker", referenceNode: self.childNode(withName: newName)! as! SKSpriteNode, referenceScene: self, action: {
                            self.run(SKAction.playSoundFileNamed("door_locked", waitForCompletion: true))
                        })
                    }
                
                }
            
                self.ballon?.setup()
                
            }
        
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        if let name=contact.bodyA.node?.name!{
            
            var newName:String {
                get {
                    return (name == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            if(PlayerModel.getInstance().keys.contains(newName)){
                self.ballon?.dismiss()
            }
        }
    }
    
    func prepareDialog() {
    
        house02d06.action = {
            
            PlayerModel.addKeys(k: "porta")
            PlayerModel.addKeys(k: "busStop")
            PlayerModel.addKeys(k: "breakfastAte")
            
            self.ballon?.dismiss()
        }
        
    }
}
