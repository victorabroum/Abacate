//
//  ClassroomScene01.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 21/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class ClassroomScene01: CustomSKSCene {
    
    override func sceneDidLoad() {
        
        super.sceneDidLoad()
        
        //Preparando a tree story dessa scene
        classRoomRootmakeTree()
        prepareDialog()
        
        self.offsetCamera = -1
        self.playerNode?.enterIdleState()
        self.playerNode?.playerCanWalk(false)
        
    }
    
    func prepareDialog(){
        
        //func b1
        let cenaProxima1: GKScene = GKScene(fileNamed: "HallScene02")!
        
        if let nextScene1 = cenaProxima1.rootNode as? HallScene02{
            nextScene1.entities = cenaProxima1.entities
            var t1 : Transicao
            t1 = Transicao(cenaAtual: self, cenaProxima: nextScene1)
            
            classRoom01c03d06.function = {
                t1.troca()
            }
            
            classRoom01d07c01d06.action = {
                PlayerModel.addKeys(k: "Iniciativa")
                t1.troca()
            }
            
            classRoom01d02c02d06.action = {
                t1.troca()
            }
            
            let sceneInfo = SceneInformation.init(previousScenario: "ClassroomScene01", actualScenario: "HallScene02")
            PlayerModel.changeScene(scene: sceneInfo)
            PlayerModel.savePlayer()
        }
        
        classRoom01d06.action = {
            let newBallon = ChoicesBallon(choices: classRoom01d06.choices, referenceNode: self.childNode(withName: "playerNodeTalk") as! SKSpriteNode, referenceScene: self)
            newBallon.setup(onNodeNamed: "playerNodeTalk")
            
        }
        
        classRoom01d01c02d06.action = {
            let fadein = SKAction.fadeIn(withDuration: 0.5)
            let fadeout = SKAction.fadeOut(withDuration: 1)
            self.run(fadeout){
                if let coiso = self.childNode(withName: "background") as? SKSpriteNode{
                    coiso.texture = SKTexture(imageNamed: "Faloneculdade")
                }
                self.run(fadein){
                    let newBallon = DialogBallon.init(rootNode: classRoom01d02c02d06, referenceScene: self)
                    newBallon.setup()
                }
                
            }
        }
        
        ballon = InteractionBallon(iconName: "", referenceNode: self.childNode(withName: "professora")! as! SKSpriteNode, referenceScene: self, action: {
            let newBallon = DialogBallon.init(rootNode: classRoom01Root, referenceScene: self)
            newBallon.setup()
        })
        ballon?.setup()
        
    }
    
    override func didMove(to view: SKView) {
        
        super.didMove(to: view)
        
        // Prepare BG Music
        if let bga = self.childNode(withName: "bgAudios") {
            print("BG AUDIOS")
            self.bgAudios = bga
            MusicHelper.startSounds(withAudios: bgAudios!.children, withVolume: 0.8)
        }
    }
}
