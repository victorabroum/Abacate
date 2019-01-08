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
    var entities = [GKEntity]()
    
    var house02Root: Node = Node(withText: "", withChoices: [])
    var ballon: Ballon?
    
    private var lastUpdateTime : TimeInterval = 0
    
    // To control BG Audios
    var bgAudios: SKNode?
    
    override func sceneDidLoad() {
        self.playerNode = childNode(withName: "playerNode") as? PlayerNode
        
        // Dizendo que a scene comanda o delegate
        physicsWorld.contactDelegate = self
        // Criando a box do diálogo
        //Preparando a tree story dessa scene
        house02makeTree()
        // Indicando a raiz da story
        
        switch escolhaFeita{
            case 0:
            self.house02Root = house02Root1
        default:
            self.house02Root = house02Root2
        }
        
        self.prepareDialog()

    }
    override func didMove(to view: SKView) {
        self.playerNode?.prepareControl(withCamera: camera!, inScene: self, withCameraOffset:-1)
        
        // Prepare BG Music
        if let bga = self.childNode(withName: "bgAudios") {
            self.bgAudios = bga
            MusicHelper.startSounds(withAudios: bgAudios!.children, withVolume: 0.2)
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
        if let nome=contact.bodyA.node?.name!{
            var novoNome:String {
                get {
                    return (nome == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            
            if (listaPermissoesHouse02.contains(novoNome)){
                
                if novoNome == "dady"{
                    
                    self.ballon = InteractionBallon(iconName: "", referenceNode: self.childNode(withName: "dady")! as! SKSpriteNode, referenceScene: self, action: {
                        let newBallon = DialogBallon.init(rootNode: self.house02Root, referenceScene: self)
                        newBallon.setup()
                    })
                    
                }else if(novoNome == "goUp"){
                    
                    ballon = StairBallon(direction: "goUp", playerNode: self.playerNode!, referenceNode: self.childNode(withName: novoNome)! as! SKSpriteNode, referenceScene: self)
                    
                }else if(novoNome == "goDown"){
                    
                    ballon = StairBallon(direction: "goDown", playerNode: self.playerNode!, referenceNode: self.childNode(withName: novoNome)! as! SKSpriteNode, referenceScene: self)
                    
                }else if novoNome == "porta"{
                    let cenaProxima:GKScene = GKScene(fileNamed: "CityScene01")!
                    if let nextScene = cenaProxima.rootNode as? CityScene01{
                        
                        nextScene.entities = cenaProxima.entities
                        self.ballon = DoorBallon(referenceNode: self.childNode(withName: "popupDoor")! as! SKSpriteNode, referenceScene: self, nextScene: nextScene)
                        
                    }
                }else if(novoNome == "dadDoor"){
                    ballon = InteractionBallon(iconName: "Icone_Locker", referenceNode: self.childNode(withName: novoNome)! as! SKSpriteNode, referenceScene: self, action: {
                        self.run(SKAction.playSoundFileNamed("door_locked", waitForCompletion: true))
                    })
                }
                
            }
            
            self.ballon?.setup()
            
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyA.node?.name!{
            
            var novoNome:String {
                get {
                    return (nome == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            if (listaPermissoesHouse02.contains(novoNome)){
                self.ballon?.dismiss()
            }
        }
    }
    
    func prepareDialog() {
    
        dHouse02Player3.action = {
            listaPermissoesCidade.remove("bakeryDoor")
            listaPermissoesHouse02.insert("porta")
            listaPermissoesHouse02.remove("dady")
            listaPermissoesCidade.remove("houseDoor")
            listaPermissoesCidade.insert("busStop")
            
            self.ballon?.dismiss()
        }
        
    }
}
