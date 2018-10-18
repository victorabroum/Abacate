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

class GameScene: SKScene {
    //Nickson objetos
    var caixa : caixaDeDialogo?
    //
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    private var playerMovement: PlayerMovement = .idle
    private var playerNode: SKSpriteNode = SKSpriteNode()
    
    override func sceneDidLoad() {
        // teste nickson
        caixa = caixaDeDialogo(personagem: playerNode, texto: "teste", direcao: .left)
        //

        self.lastUpdateTime = 0
        self.playerNode = childNode(withName: "Player") as! SKSpriteNode
        
        // Cria a tree para cena
        // makeTreeOfRoom()
        
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
            //nickson teste//
            caixa?.removeFromParent()
            playerNode.addChild(caixa!)
            caixa?.entrar()
            //
        case .left:
            self.playerNode.position.x -= playerVelocity
            //teste nickson
            caixa?.sair()
            //
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
    
}
