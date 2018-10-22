//
//  GameScene.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 17/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import SpriteKit
import GameplayKit

enum PlayerMovement {
    case right
    case left
    case idle
    case up
    case down
}

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    var caixa : caixaDeDialogo?
    var escolhas : baloesDeEscolha?
    var indexNode : Node?
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    private var playerMovement: PlayerMovement = .idle
    private var playerNode: SKSpriteNode = SKSpriteNode()
    
    override func sceneDidLoad() {
        
        makeTreeOfRoom()
        indexNode = rootNode

        self.lastUpdateTime = 0
        self.playerNode = childNode(withName: "Player") as! SKSpriteNode
        
        // Cria a tree para cena
        // makeTreeOfRoom()
        physicsWorld.contactDelegate = self
        
        
    }
    
    public func drawnDialog(){
        
//        caixa = caixaDeDialogo(personagem: playerNode, texto: indexNode!.text, cena: self)
//        if(indexNode!.childrens.first != nil){
//            indexNode = indexNode!.childrens.first
//        }
//        caixa?.entrar()
        
        if(indexNode != nil){
            caixa = caixaDeDialogo(personagem: playerNode, texto: indexNode!.text, cena: self)
            indexNode = indexNode!.childrens.first
            caixa?.entrar()
        }
    }
    
    override func didMove(to view: SKView) {
        if let pcComponent = self.playerNode.entity?.component(ofType: PlayerControl.self){
            pcComponent.setupControllers(camera: camera!, scene: self)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        switch self.playerMovement {
        case .right:
            self.playerNode.position.x += playerVelocity
        case .left:
            self.playerNode.position.x -= playerVelocity
        case .up:
            self.playerNode.position.y += playerVelocity
        case .down:
            self.playerNode.position.y -= playerVelocity
            // Se quiser mudar de scene é assim
            // Basta pedir para scene atual apresentar a scene que deseja ir
            // A transição é opcional mas é pra ficar bonito
//            print("Vamos para a prox scene")
//            let transition: SKTransition = SKTransition.fade(withDuration: 1)
//            if let roomScene = RoomScene(fileNamed: "RoomScene"){
//                self.view?.presentScene(roomScene, transition: transition)
//            }
        default:
            // Idle
            break
        }
    }
    
    public func movePlayer(command: String) -> () {
        switch command {
        case "right":
            self.playerMovement = .right
        case "left":
            self.playerMovement = .left
        case "up":
            self.playerMovement = .up
        case "down":
            self.playerMovement = .down
        default:
            // Idle
            self.playerMovement = .idle
            break
        }
    }
    func didBegin(_ contact: SKPhysicsContact) {
        
        if let nome=contact.bodyA.node?.name!{
            caixa = caixaDeDialogo(personagem: contact.bodyA.node!, texto: (lista[nome]?.mensagem)!, cena: self)
            lista["caixa"]?.funcaoEntrada = {(n:caixaDeDialogo)->Void in n.entrar()}
            lista["caixa"]?.funcaoSaida = {(n:caixaDeDialogo)->Void in n.sair()}
            lista[nome]?.funcaoEntrada!(caixa!)
        }
    }
    func didEnd(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyA.node?.name!{
            print(nome)
            lista[nome]?.funcaoSaida!(caixa!)
        }
    }
}
