//
//  BakeryScene01.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 21/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class BakeryScene01: SKScene, SKPhysicsContactDelegate {
    
    var playerNode: PlayerNode?
    var ballon: Ballon?
    var padeiroNode: SKSpriteNode?
    
    var entities = [GKEntity]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    // To control BG Audios
    var bgAudios: SKNode?
    
    override func sceneDidLoad() {
        self.playerNode = childNode(withName: "playerNode") as? PlayerNode
        self.padeiroNode = self.childNode(withName: "padeirocorpo") as? SKSpriteNode
        
        // Dizendo que a scene comanda o delegate
        physicsWorld.contactDelegate = self
        //Preparando a tree story dessa scene
        makeTreeOfRoomPadaria()
        self.prepareDialoge()
        
    }
    
    override func didMove(to view: SKView) {
        self.playerNode?.prepareControl(withCamera: camera!, inScene: self, withCameraOffset:-1)
        
        // Prepare BG Music
        if let bga = self.childNode(withName: "bgAudios") {
            self.bgAudios = bga
            MusicHelper.startSounds(withAudios: bgAudios!.children, withVolume: 0.8)
        }
    }
    
    override func willMove(from view: SKView) {
        if self.bgAudios != nil{
            MusicHelper.stopSounds(withAudios: self.bgAudios!.children)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.playerNode!.makePlayerWalk()
    }

    func didBegin(_ contact: SKPhysicsContact) {
        print("deu colisao")
        if let nome=contact.bodyA.node?.name!{
            var novoNome:String {
                get {
                    return (nome == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            
            
            if (listaPermissoesPadaria.contains(novoNome)){
                
                if novoNome == "padeiro"{
                    
                    ballon = InteractionBallon(iconName: "", referenceNode: self.childNode(withName: "padeiroCaixa")! as! SKSpriteNode, referenceScene: self, action: {
                        let auxBallon = DialogBallon.init(rootNode: rootNodePadaria, referenceNode: self.playerNode!, referenceScene: self)
                        auxBallon.setup()
//                        self.prepareDialoge()
                    })
                    
                    
                    
                }else if novoNome == "porta"{
                    let cenaProxima:GKScene = GKScene(fileNamed: "CityScene01")!
                    if let nextScene = cenaProxima.rootNode as? CityScene01{
                        
                        nextScene.playerNode!.position = (nextScene.childNode(withName: "initPosition")?.childNode(withName: "bakery")?.position)!
                        nextScene.entities = cenaProxima.entities
                        
                        ballon = DoorBallon(referenceNode: self.playerNode!, referenceScene: self, nextScene: nextScene)
                        
                        
                        
                    }
                }
                
                ballon?.setup()
                
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
            
            if (listaPermissoesPadaria.contains(novoNome)){
                ballon!.dismiss()
            }
        }
    }
    
    
    func prepareDialoge() {
        rootNodePadaria.action = {
            self.padeiroNode?.run(SKAction(named: "sweet_brad")!, completion: {
                self.ballon = DialogBallon.init(rootNode: secondTalkPadaria, referenceNode: self.padeiroNode!, referenceScene: self)
                self.ballon?.setup()
//                self.dialogBox01?.drawnDialog()
            })
            
        }
        
        bakery01D4.action = {
            
            listaPermissoesPadaria.insert("porta")
            listaPermissoesCidade.remove("bakeryDoor")
            listaPermissoesCidade.insert("houseDoor")
            listaPermissoesPadaria.remove("padeiro")
            
            self.ballon?.dismiss()
//            self.dialogBox01?.drawnDialog()
            self.padeiroNode?.texture = SKTexture(imageNamed: "idle_baker")
        }
        
        func justSair() {
//            self.dialogBox01?.escolhas?.sair()
            self.ballon?.dismiss()
            self.padeiroNode?.run(SKAction(named: "french_brad")!, completion: {
                
                self.ballon = DialogBallon.init(rootNode: bakery01D3, referenceNode: self.padeiroNode!, referenceScene: self)
                self.ballon?.setup()
            })
        }
        
        rVcErrou.function = {
            // Ele volta para pegar o pão francês
            justSair()
        }
        
        rVcErrouDeNovo.function = {
            // Ele volta para pegar o pão francês
            justSair()
        }
        
        rObrigado.function = {
            
            listaPermissoesPadaria.insert("porta")
            listaPermissoesCidade.remove("bakeryDoor")
            listaPermissoesCidade.insert("houseDoor")
            listaPermissoesPadaria.remove("padeiro")
            
            // Sumi textura do pão
            // Ele vai levar o pão errado mesmo
            escolhaFeita = 0
//            self.dialogBox01?.escolhas?.sair()
            self.ballon?.dismiss()
            self.padeiroNode?.texture = SKTexture(imageNamed: "idle_baker")
//            self.dialogBox01?.drawnDialog()
        }
        
    }
    
}
