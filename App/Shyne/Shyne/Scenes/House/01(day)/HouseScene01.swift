//
//  HouseScene01.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 21/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class HouseScene01: SKScene, SKPhysicsContactDelegate {
    
    var playerNode: PlayerNode?
    var dialogBox01: Dialogavel?
    
    var entities = [GKEntity]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    // To control BG Audios
    var bgAudios: SKNode?
    
    override func sceneDidLoad() {
        self.playerNode = childNode(withName: "playerNode") as? PlayerNode
        
        // Dizendo que a scene comanda o delegate
        physicsWorld.contactDelegate = self
        // Criando a box do diálogo
        self.dialogBox01 = Dialogavel(cena: self)
        //Preparando a tree story dessa scene
        house01makeTree()
        // Indicando a raiz da story
        self.dialogBox01!.indexNode = house01Root
    }
    
    override func didMove(to view: SKView) {
        print("ANTES SIZE \((self.playerNode?.yScale)!)") 
        self.playerNode?.prepareControl(withCamera: camera!, inScene: self, withCameraOffset:-1)
        
        // Prepare BG Music
        if let bga = self.childNode(withName: "bgAudios") {
            self.bgAudios = bga
            MusicHelper.startSounds(withAudios: bgAudios!.children, withVolume: 0.2)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if(dialogBox01?.indexNode == nil){
                listaPermissoesHouse01.insert("porta")
                listaPermissoesHouse01.remove("triggerDad")
        }
        self.playerNode!.makePlayerWalk()
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
            
            print(novoNome)
            if novoNome == "triggerDad"{
                self.dialogBox01!.caixa = caixaDeDialogo(personagem: self.childNode(withName: "dad")!, texto: (lista[novoNome]?.mensagem)!, dialogavel: self.dialogBox01!)
                    falouComPaiNaCasa01 = true
            }else if novoNome == "porta"{
                let cenaProxima:GKScene = GKScene(fileNamed: "CityScene01")!
                if let nextScene = cenaProxima.rootNode as? CityScene01{
                    nextScene.entities = cenaProxima.entities
                    self.dialogBox01!.caixa = caixaDeTrocaDeCena(personagem: self.playerNode!, dialogavel: self.dialogBox01!, texture: "Icone_Door", cenaAtual: self, cenaProxima: nextScene)
                }
            }else if(novoNome == "goUp"){
                if let upPos = self.childNode(withName: "goDown"){
                    
                    self.dialogBox01?.caixa = caixaDeEscada(personagem: self.childNode(withName: novoNome)!, dialogavel: self.dialogBox01!, texture: "Icone_Upstairs", function: {
                        
                        if (self.playerNode?.xScale)! >= 0{
                            self.playerNode?.xScale *= -1
                        }
                        
                        self.playerNode?.makeMove(fromPosition: (self.childNode(withName: novoNome)?.position)!, toPosition: CGPoint(x: upPos.position.x, y: upPos.position.y), withDuration: stairDuration)
                        self.camera?.run(SKAction.moveTo(y: cameraUpper, duration: stairDuration))
                    })
                }
            }else if(novoNome == "goDown"){
                if let downPos = self.childNode(withName: "goUp"){
                    self.dialogBox01?.caixa = caixaDeEscada(personagem: self.childNode(withName: novoNome)!, dialogavel: self.dialogBox01!, texture: "Icone_Downstairs", function: {
                        if (self.playerNode?.xScale)! <= 0{
                            self.playerNode?.xScale *= -1
                        }
                        self.playerNode?.makeMove(fromPosition: (self.childNode(withName: novoNome)?.position)!, toPosition: CGPoint(x: downPos.position.x, y: downPos.position.y), withDuration: stairDuration)
                        self.camera?.run(SKAction.moveTo(y: cameraDown, duration: stairDuration))
                    })
                }
            }else if(novoNome == "dadDoor"){
                self.dialogBox01?.caixa = caixaDeEscada(personagem: self.childNode(withName: novoNome)!, dialogavel: self.dialogBox01!, texture: "Icone_Locker", function: {
                    self.run(SKAction.playSoundFileNamed("door_locked", waitForCompletion: true))
                })
            }
            
            if (listaPermissoesHouse01.contains(novoNome)){
                lista[novoNome]?.funcaoEntrada = {(n:caixa)->Void in n.entrar()}
                lista[novoNome]?.funcaoSaida = {(n:caixa)->Void in n.sair()}
                lista[novoNome]?.funcaoEntrada!(self.dialogBox01!.caixa!)
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
            if (listaPermissoesHouse01.contains(novoNome)){
                lista[novoNome]?.funcaoSaida!(self.dialogBox01!.caixa!)
            }
        }
    }
}
