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
                    self.add(firula, random: false)
                }
            }
            
        }

    }
    
    func addPeople(withRandom random: Bool = true, withScale scale: CGFloat = 0.1){
        
        if (Int.random(in: 0...100)%2==0){
            self.addFred(withRandom: random, withScale: scale, yPosition: -126)
        }else{
            self.addJennifer(withRandom: random, withScale: scale, yPosition: -132)
        }
    }
    
    func addCar(withRandom random: Bool = true){
        let carName = Int.random(in: 0...10) % 2 == 0 ? "redCar" : "blueCar"
        
        let frames = SKTexture.createTexture(carName)
        
        
        let carNode = SKSpriteNode(texture: frames[0])
        carNode.name = carName
        carNode.position.y = -140
        carNode.zPosition = 10
        
        carNode.run(SKAction.repeatForever(SKAction.animate(with: frames, timePerFrame: 0.2)))
        
        self.add(carNode, random: random)
    }
    
    func ajustYPosition(name: String, y: CGFloat){
        for node in self.listOfFirulas{
            if(node.name != nil && node.name! == name){
                node.position.y = y
            }
        }
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

extension FirulasController{
    func addFred(withRandom random: Bool = true, withScale scale: CGFloat = 0.1, yPosition y: CGFloat, withDuration duration: TimeInterval = TimeInterval.random(in: 100...150)){
        let peopleName = "fred"
        
        let frames = SKTexture.createTexture(peopleName)
        
        let peopleNode = SKSpriteNode(texture: frames[0])
        peopleNode.name = peopleName
        peopleNode.yScale = scale
        peopleNode.xScale = scale
        peopleNode.position.y = y
        
        peopleNode.run(SKAction(named: "\(peopleName)_walk")!)
        
        self.add(peopleNode, withDuration: TimeInterval.random(in: 100...150), random: random)
    }
    
    func addJennifer(withRandom random: Bool = true, withScale scale: CGFloat = 0.1, yPosition y: CGFloat, withDuration duration: TimeInterval = TimeInterval.random(in: 100...150)){
        let peopleName = "jennifer"
        
        let frames = SKTexture.createTexture(peopleName)
        
        let peopleNode = SKSpriteNode(texture: frames[0])
        peopleNode.name = peopleName
        peopleNode.yScale = scale
        peopleNode.xScale = scale
        peopleNode.position.y = y
        
        peopleNode.run(SKAction(named: "\(peopleName)_walk")!)
        
        self.add(peopleNode, withDuration: duration, random: random)
    }
}
