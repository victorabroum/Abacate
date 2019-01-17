//
//  CityFirulasController.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 16/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation
import SpriteKit

class FirulasController {
    var listOfFirulas: [SKSpriteNode] = []
    
    var scene: SKScene
    
    init(scene: SKScene){
        self.scene = scene
    }
    
    func add(_ firula: SKSpriteNode, withDuration duration: TimeInterval = TimeInterval.random(in: 30...50), random: Bool = true){
        listOfFirulas.append(firula)
        
        // Add Firula no Node Firulas em cena
        var firulasNode = SKNode()
        if let node = self.scene.childNode(withName: "firulas"){
            firulasNode = node
        }else{
            firulasNode.name = "firulas"
            firulasNode.zPosition = 100
            self.scene.addChild(firulasNode)
        }
        
        self.scene.childNode(withName: "firulas")?.addChild(firula)
        
        if let backgroundNode = self.scene.childNode(withName: "background") as? SKSpriteNode{
            
            // Começar a Firula random ou no lado direito ou no esquerdo da cena
            firula.position.x = Int.random(in: 0...100)%2 == 0 ? backgroundNode.size.width : (-backgroundNode.size.width)
            
            // Botar a firula na direção certa
            if(firula.position.x > 0){
                firula.xScale *= -1
            }
            
            // Action da firula se mexer
            firula.run(SKAction.moveTo(x: (firula.position.x < 0) ? backgroundNode.size.width + 300 : -(backgroundNode.size.width + 300), duration: duration)){
                firula.removeFromParent()
                
                if (random){
                    if (Int.random(in: 0...100) % 2 == 0){
                        self.addPeople()
                    }else{
                        self.addCar()
                    }
                }else{
                    self.add(firula)
                }
            }
            
        }

    }
    
    func addPeople(withRandom random: Bool = true){
        let peopleName = Int.random(in: 0...100) % 2 == 0 ? "jennifer" : "fred"
        
        let frames = SKTexture.createTexture(peopleName)
        
        let peopleNode = SKSpriteNode(texture: frames[0])
        peopleNode.yScale = 0.1
        peopleNode.xScale = 0.1
        peopleNode.position.y = (peopleName == "fred") ? -126 : -132
        
        peopleNode.run(SKAction(named: "\(peopleName)_walk")!)
        
        self.add(peopleNode, withDuration: TimeInterval.random(in: 100...150), random: random)
    }
    
    func addCar(withRandom random: Bool = true){
        let carName = Int.random(in: 0...10) % 2 == 0 ? "redCar" : "blueCar"
        
        let frames = SKTexture.createTexture(carName)
        
        
        let carNode = SKSpriteNode(texture: frames[0])
        carNode.position.y = -140
        carNode.zPosition = 10
        
        carNode.run(SKAction.repeatForever(SKAction.animate(with: frames, timePerFrame: 0.2)))
        
        self.add(carNode, random: random)
    }
}

extension SKTexture {
    
    static func createTexture(_ name:String) -> [SKTexture]{
        let textureAtlas = SKTextureAtlas(named: name)
        var frames = [SKTexture]()
        
        for i in 1...textureAtlas.textureNames.count - 1{
            frames.append(textureAtlas.textureNamed(textureAtlas.textureNames[i]))
        }
        return frames
    }
}
