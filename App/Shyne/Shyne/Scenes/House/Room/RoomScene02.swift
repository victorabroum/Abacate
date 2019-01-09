//
//  RoomScene02.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 21/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class RoomScene02: SKScene,SKPhysicsContactDelegate {
    
    var playerNode:PlayerNode?
    
    var ballon: Ballon?
    
    var entities = [GKEntity]()
    
    // To control BG Audios
    var bgAudios: SKNode?
    
    override func sceneDidLoad() {
        playerNode = self.childNode(withName: "playerNode" ) as? PlayerNode
        
        physicsWorld.contactDelegate = self
        
        // Prepare Dialog
        prepareDialog()
        
    }
    
    override func didMove(to view: SKView) {
        self.playerNode?.prepareControl(withCamera: camera!, inScene: self, withCameraOffset: -1)
        
        // Prepare BG Music
        if let bga = self.childNode(withName: "bgAudios") {
            self.bgAudios = bga
            MusicHelper.startSounds(withAudios: bgAudios!.children, withVolume: 0.2)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.playerNode?.makePlayerWalk()
    }
    
    override func willMove(from view: SKView) {
        if self.bgAudios != nil{
            MusicHelper.stopSounds(withAudios: self.bgAudios!.children)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyA.node?.name!{
            var novoNome:String {
                get {
                    return (nome == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            
            
            if(listaPermissoesRoom02.contains(novoNome)){
                
                if novoNome == "cama"{
                    
                    self.ballon = InteractionBallon(iconName: "", referenceNode: self.childNode(withName: novoNome)! as! SKSpriteNode, referenceScene: self, action: {
                        let newBallon = DialogBallon.init(rootNode: room02Root, referenceScene: self)
                        newBallon.setup()
                    })
                   
                }
                
                self.ballon?.setup()
                
            }
        }
    }
    func didEnd(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyA.node?.name!{
            
            var novoNome:String {
                get {
                    return (nome == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            if(listaPermissoesRoom02.contains(novoNome)){
                self.ballon?.dismiss()
            }
        }
    }
    
    func prepareDialog(){
        
        room02Root.action = {
            
            listaPermissoesRoom02.remove("cama")
            
            let cenaProxima = SKScene(fileNamed: "EndGame")
            
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            cenaProxima!.scaleMode = SKSceneScaleMode.aspectFill
            self.view?.presentScene(cenaProxima!, transition: transition)
            
        }
        
    }
}
