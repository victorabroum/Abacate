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
        house02makeTree()
        // Indicando a raiz da story
        switch escolhaFeita{
            case 0:
            self.dialogBox01!.indexNode = house02Root1
        default:
            self.dialogBox01!.indexNode = house02Root2
        }

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
        if(dialogBox01?.indexNode == nil){
            listaPermissoesCidade.remove("bakeryDoor")
            listaPermissoesHouse02.insert("porta")
            listaPermissoesHouse02.remove("dady")
            listaPermissoesCidade.remove("houseDoor")
            listaPermissoesCidade.insert("busStop")
        }
    }
    func didBegin(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyA.node?.name!{
            var novoNome:String {
                get {
                    return (nome == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            
            if novoNome == "dady"{
                self.dialogBox01!.caixa = caixaDeDialogo(personagem: self.childNode(withName: "dady")!, texto: (lista[novoNome]?.mensagem)!, dialogavel: dialogBox01!)
            }else if(novoNome == "goUp"){
                if let upPos = self.childNode(withName: "goDown"){
                    
                    self.dialogBox01?.caixa = caixaDeEscada(personagem: self.childNode(withName: novoNome)!, dialogavel: self.dialogBox01!,texture: "Icone_Upstairs", function: {
                        
                        if (self.playerNode?.xScale)! >= 0{
                            self.playerNode?.xScale *= -1
                        }
                        
                        self.playerNode?.makeMove(fromPosition: (self.childNode(withName: novoNome)?.position)!, toPosition: CGPoint(x: upPos.position.x, y: upPos.position.y), withDuration: stairDuration)
                        self.camera?.run(SKAction.moveTo(y: cameraUpper, duration: stairDuration))
                    })
                }
            }else if(novoNome == "goDown"){
                if let downPos = self.childNode(withName: "goUp"){
                    self.dialogBox01?.caixa = caixaDeEscada(personagem: self.childNode(withName: novoNome)!, dialogavel: self.dialogBox01!,texture: "Icone_Downstairs", function: {
                        if (self.playerNode?.xScale)! <= 0{
                            self.playerNode?.xScale *= -1
                        }
                        self.playerNode?.makeMove(fromPosition: (self.childNode(withName: novoNome)?.position)!, toPosition: CGPoint(x: downPos.position.x, y: downPos.position.y), withDuration: stairDuration)
                        self.camera?.run(SKAction.moveTo(y: cameraDown, duration: stairDuration))
                    })
                }
            }else if novoNome == "porta"{
                let cenaProxima:GKScene = GKScene(fileNamed: "CityScene01")!
                if let nextScene = cenaProxima.rootNode as? CityScene01{
                    nextScene.entities = cenaProxima.entities
                    self.dialogBox01!.caixa = caixaDeTrocaDeCena(personagem: self.playerNode!, dialogavel: self.dialogBox01!, texture: "Icone_Door", cenaAtual: self, cenaProxima: nextScene)
                }
            }else if(novoNome == "dadDoor"){
                self.dialogBox01?.caixa = caixaDeEscada(personagem: self.childNode(withName: novoNome)!, dialogavel: self.dialogBox01!, texture: "Icone_Locker", function: {
                    self.run(SKAction.playSoundFileNamed("door_locked", waitForCompletion: true))
                })
            }
            
            
            
            if (listaPermissoesHouse02.contains(novoNome)){
                lista[novoNome]?.funcaoEntrada = {(n:caixa)->Void in n.entrar()}
                lista[novoNome]?.funcaoSaida = {(n:caixa)->Void in n.sair()}
                lista[novoNome]?.funcaoEntrada!(dialogBox01!.caixa!)
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
            
            if (listaPermissoesHouse02.contains(novoNome)){
                lista[novoNome]?.funcaoSaida!(dialogBox01!.caixa!)
            }
        }
    }
}
