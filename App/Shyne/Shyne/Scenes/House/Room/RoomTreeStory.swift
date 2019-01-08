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
var rootNode: Node = Node(withText: "It looks like it's \ngonna be cold today..", withChoices: [])

// D2
var secondTalk: Node = Node(withText: "Wish I didn't have to\ngo to school..", withChoices: [])

//D3
var terceiraTalk = Node(withText: "Well... I'm hungry", withChoices: [])

//D4
var quartaTalk = Node(withText: "I better come \ndownstairs and eat..", withChoices: [])






// Construindo o fluxo
func makeTreeOfRoom() -> (){
    
    rootNode.add(child: secondTalk)
    secondTalk.add(child: terceiraTalk)
    terceiraTalk.add(child: quartaTalk)
}
