//
//  Tree.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 18/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation
import SpriteKit

struct Feel{
    var happy: Float = 0.0
    var normal: Float = 0.0
    var shy: Float = 0.0
    
    init(happy: Float, normal: Float, shy: Float) {
        self.happy = happy
        self.normal = normal
        self.shy = shy
    }
}

class Answer{
    var text: String
    var amount: Feel
    var child: [Node]
    var audioName: String
    //nickson teste/////////
    var function: (()->Void)?
    ////////////////////////
    
    init(withText text: String, withAmount amount: Feel, audioName: String = "") {
        self.text = text
        self.amount = amount
        self.child = []
        self.audioName = audioName
    }
    
    init(withText text: String, withAmount amount: Feel, withChild child: [Node]) {
        self.text = text
        self.amount = amount
        self.child = child
        self.audioName = ""
    }
}

extension Answer: CustomStringConvertible{
    var description: String {
        get {
            return "Choie - \(text)\n"
        }
    }
}

class Node {
    var typeBallon: TypeBallon = .speak
    var text: String
    var choices: [Answer]
    var childrens: [Node] = []
    var nodeToTalk: String
    weak var parent: Node? // this is parent
    var action: (()->Void)?
    var audioName: String
    
    init(withText text: String, withChoices choices: [Answer], typeBallon: TypeBallon = .speak) {
        self.text = text
        self.choices = choices
        self.nodeToTalk = "playerNode"
        self.audioName = ""
        self.typeBallon = typeBallon
    }
    
    init(withText text: String, withChoices choices: [Answer], inNodeNamed node: String) {
        self.text = text
        self.choices = choices
        self.nodeToTalk = node
        self.audioName = ""
    }
    
    init(withText text: String, withChoices choices: [Answer], inNodeNamed node: String, audioName: String = "", typeBallon: TypeBallon = .speak, function: (() -> Void)? = nil) {
        self.text = text
        self.choices = choices
        self.nodeToTalk = node
        self.action = function
        self.audioName = audioName
        self.typeBallon = typeBallon
    }
    
    
    func add(child: Node){
        childrens.append(child)
        child.parent = self
    }
    
    func getNodeReference(named name: String, inScene scene: SKScene) -> SKSpriteNode? {
        if let node: SKSpriteNode = scene.childNode(withName: name) as? SKSpriteNode{
            return node
        }
        return nil
    }
}
