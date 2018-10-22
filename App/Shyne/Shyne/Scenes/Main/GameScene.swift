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
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    
    private var playerMovement: PlayerMovement = .idle
    private var playerNode: SKSpriteNode = SKSpriteNode()
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        self.playerNode = childNode(withName: "playerNode") as! SKSpriteNode
        
        // Cria a tree para cena
        house01makeTree()
        print("Tree of house 1 => \n \(house01Root)")
        print("Um teste \(house01Root.childrens[0].choices)")
        physicsWorld.contactDelegate = self
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
        if let nome=contact.bodyB.node?.name!{
            lista[nome]?.funcaoEntrada()
        }
    }
    func didEnd(_ contact: SKPhysicsContact) {
        if let nome=contact.bodyB.node?.name!{
            lista[nome]?.funcaoSaida()
        }
    }
}
