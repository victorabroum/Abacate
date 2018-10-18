//
//  Tree.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 18/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation

class Answer{
    var text: String
    
    init(withText text: String) {
        self.text = text
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
