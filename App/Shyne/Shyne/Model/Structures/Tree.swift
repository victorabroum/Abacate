//
//  Tree.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 18/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation

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
    
    init(withText text: String, withAmount amount: Feel) {
        self.text = text
        self.amount = amount
        self.child = []
    }
    
    init(withText text: String, withAmount amount: Feel, withChild child: [Node]) {
        self.text = text
        self.amount = amount
        self.child = child
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
    var text: String
    var choices: [Answer]
    var childrens: [Node] = []
    weak var parent: Node? // this is parent
    
    
    init(withText text: String, withChoices choices: [Answer]) {
        self.text = text
        self.choices = choices
    }
    
    func add(child: Node) -> () {
        childrens.append(child)
        child.parent = self
    }
}

extension Node: CustomStringConvertible {
    
    var description: String{
        get{
            if !childrens.isEmpty {
                text += " {" + childrens.map { $0.description }.joined(separator: ", ") + "} "
            }
            return text
        }
        
    }
}
