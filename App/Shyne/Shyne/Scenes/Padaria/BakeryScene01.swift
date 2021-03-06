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
    var dialogBox01: Dialogavel?
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
        // Criando a box do diálogo
        self.dialogBox01 = Dialogavel(cena: self)
        //Preparando a tree story dessa scene
        makeTreeOfRoomPadaria()
        // Indicando a raiz da story
        self.dialogBox01!.indexNode = rootNodePadaria
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
        if(dialogBox01?.indexNode == nil){
            listaPermissoesPadaria.insert("porta")
            listaPermissoesCidade.remove("bakeryDoor")
            listaPermissoesCidade.insert("houseDoor")
            listaPermissoesPadaria.remove("padeiro")
        }
    }

    func didBegin(_ contact: SKPhysicsContact) {
        print("deu colisao")
        if let nome=contact.bodyA.node?.name!{
            var novoNome:String {
                get {
                    return (nome == "playerNode" ? contact.bodyB.node?.name : contact.bodyA.node?.name)!
                }
            }
            
            
            if novoNome == "padeiro"{
                print("Padeiro")
                self.dialogBox01!.caixa = caixaDeDialogo(personagem: self.childNode(withName: "padeiroCaixa")!, texto: (lista[novoNome]?.mensagem)!, dialogavel: self.dialogBox01!)
            }else if novoNome == "porta"{
                let cenaProxima:GKScene = GKScene(fileNamed: "CityScene01")!
                if let nextScene = cenaProxima.rootNode as? CityScene01{
                    nextScene.playerNode!.position = CGPoint(x: -748.625, y: -126.709)
                    nextScene.entities = cenaProxima.entities
                    self.dialogBox01!.caixa = caixaDeTrocaDeCena(personagem: self.playerNode!, dialogavel: self.dialogBox01!, texture: "Icone_Door", cenaAtual: self, cenaProxima: nextScene)
                }
            }
            if (listaPermissoesPadaria.contains(novoNome)){
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
            
            if (listaPermissoesPadaria.contains(novoNome)){
                lista[novoNome]?.funcaoSaida!(dialogBox01!.caixa!)
            }
        }
    }
    
    
    func prepareDialoge() {
        rootNodePadaria.action = {
            self.padeiroNode?.run(SKAction(named: "sweet_brad")!, completion: {
                self.dialogBox01?.drawnDialog()
            })
            
        }
        
        bakery01D4.action = {
            self.dialogBox01?.drawnDialog()
            self.padeiroNode?.texture = SKTexture(imageNamed: "idle_baker")
        }
        
        func justSair() {
            self.dialogBox01?.escolhas?.sair()
            self.padeiroNode?.run(SKAction(named: "french_brad")!, completion: {
                self.dialogBox01?.drawnDialog()
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
            // Sumi textura do pão
            // Ele vai levar o pão errado mesmo
            escolhaFeita = 0
            self.dialogBox01?.escolhas?.sair()
            self.dialogBox01?.indexNode = nil
            self.padeiroNode?.texture = SKTexture(imageNamed: "idle_baker")
            self.dialogBox01?.drawnDialog()
        }
        
    }
    
}
