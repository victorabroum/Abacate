//
//  CityScene01.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 21/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class CityScene01: SKScene, SKPhysicsContactDelegate{
    
    var playerNode: PlayerNode?
    var dialoge: Dialogavel?
    var musicsNode: SKNode?
    
    
    var entities = [GKEntity]()
    
    override func sceneDidLoad() {
        self.playerNode = self.childNode(withName: "playerNode") as? PlayerNode
        self.dialoge = Dialogavel(cena: self)
        if let musicNode = self.childNode(withName: "musics") {
            self.musicsNode = musicNode
        }
        
        physicsWorld.contactDelegate = self
    }
    
    override func didMove(to view: SKView) {
        self.playerNode?.prepareControl(withCamera: camera!, inScene: self, withCameraOffset: 120)
        MusicPanHelper.prepareForPan(thisScne: self, forThisListner: self.playerNode!, fromThisMusics: (self.musicsNode?.children)!)
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.playerNode?.makePlayerWalk()
        
        MusicPanHelper.updateMusicPan(inSpace: self.frame.size, forThisListner: self.playerNode!, fromThisMusicNodes: (self.musicsNode?.children)!)
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyA.node?.name!{
            var novoNome:String {
                get {
                    return (nome == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            if novoNome == "bakeryDoor"{
                
                let cenaProxima:GKScene = GKScene(fileNamed: "BakeryScene01")!
                if let nextScene = cenaProxima.rootNode as? BakeryScene01{
                    nextScene.entities = cenaProxima.entities
                    let trigger = self.childNode(withName: "trigger")?.childNode(withName: novoNome)!
                    dialoge?.caixa = caixaDeTrocaDeCena(personagem: trigger!, dialogavel: dialoge!, cenaAtual: self, cenaProxima: nextScene)
                }
                
            }
            
            if finishedBakery{
                if(novoNome == "busStop"){
                    // Rola a animação do bus e depois vai para a sala de aula
                    
                    // Go to Classroom
                    if let cenaProxima: GKScene = GKScene(fileNamed: "ClassroomScene01"){
                        if let nextScene = cenaProxima.rootNode as? ClassroomScene01{
                            nextScene.entities = cenaProxima.entities
                            let trigger = self.childNode(withName: "trigger")?.childNode(withName: novoNome)!
                            self.dialoge?.caixa = caixaDeEscada(personagem: trigger!, dialogavel: self.dialoge!, function: {
                                // Rola a animação do bus pegando o cara
                                self.busAnimate(nextScene)
                            })
                            
//                            caixaDeTrocaDeCena(personagem: trigger!, dialogavel: self.dialoge!, cenaAtual: self, cenaProxima: nextScene)
                        }
                    }
                    
                }
                
                if(novoNome == "houseDoor"){
                    // Go to House 02
                    if let cenaProxima: GKScene = GKScene(fileNamed: "HouseScene02"){
                        if let nextScene = cenaProxima.rootNode as? HouseScene02{
                            nextScene.entities = cenaProxima.entities
                            let trigger = self.childNode(withName: "trigger")?.childNode(withName: novoNome)!
                            dialoge?.caixa = caixaDeTrocaDeCena(personagem: trigger!, dialogavel: dialoge!, cenaAtual: self, cenaProxima: nextScene)
                        }
                    }
                }
            }
            
            if (listaPermissoesCidade.contains(novoNome)){
                lista[novoNome]?.funcaoEntrada = {(n:caixa)->Void in n.entrar()}
                lista[novoNome]?.funcaoSaida = {(n:caixa)->Void in n.sair()}
                lista[novoNome]?.funcaoEntrada!(dialoge!.caixa!)
                
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
            if (listaPermissoesCidade.contains(novoNome)){
                lista[novoNome]?.funcaoSaida!(dialoge!.caixa!)
            }
        }
    }
    
    
    func busAnimate(_ nextScene: SKScene) {
        self.playerNode?.playerCanWalk(false)
        let busNode = SKSpriteNode(imageNamed: "bus")
        busNode.position.y = -83
        busNode.zPosition = playerZPosition + 100
        self.addChild(busNode)
        
        let arrive = SKAction.moveTo(x: (self.playerNode?.position.x)! + 20, duration: 3)
        let wait = SKAction.wait(forDuration: 0.5)
        let goWay = SKAction.move(by: CGVector(dx: 500, dy: 0), duration: 2)
        let sequence = SKAction.sequence([arrive, wait])
        
        
        busNode.run(sequence, completion: {
            // Troca de cena
            self.playerNode?.alpha = 0
            busNode.run(goWay, completion: {
                let transition:SKTransition = SKTransition.fade(withDuration: 0.5)
                nextScene.scaleMode = SKSceneScaleMode.aspectFill
                self.view?.presentScene(nextScene, transition: transition)
            })
            })
    }
    
}
