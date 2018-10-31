//
//  RoomTreeStory.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 18/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation

// D = Diálogo, Cena do quarto
// D1
var rootNode: Node = Node(withText: "Hoje parece que vai ser frio", withChoices: [])

// D2
var secondTalk: Node = Node(withText: "Queria nao ter que\nir para a faculdade", withChoices: [])

//D3
var terceiraTalk = Node(withText: "Tô é com fome", withChoices: [])

//D4
var quartaTalk = Node(withText: "Vou descer para comer", withChoices: [])

// Construindo o fluxo
func makeTreeOfRoom() -> (){
    rootNode.add(child: secondTalk)
    secondTalk.add(child: terceiraTalk)
    terceiraTalk.add(child: quartaTalk)
}
