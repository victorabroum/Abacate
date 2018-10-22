//
//  RoomTreeStory.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 18/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation

// D = Diálogo, Cena do quarto
// D1 -> D2
var textForRoot: String = "Qual casaco uso hoje?"
var cBlack: Answer = Answer(withText: "Preto", withAmount: Feel(happy: 0, normal: 0.5, shy: 0.3))
var cPurple: Answer = Answer(withText: "Roxo", withAmount: Feel(happy: 0.5, normal: 0.1, shy: 0.2))
var cBlue: Answer = Answer(withText: "Azul", withAmount: Feel(happy: 0.6, normal: 0.1, shy: 0))
var rootNode: Node = Node(withText: textForRoot, withChoices: [cBlack, cPurple, cBlue])

// D2 -> End
var textSecondTalk: String = "Então vai ser esse!"
var secondTalk: Node = Node(withText: textSecondTalk, withChoices: [])

// Construindo o fluxo
func makeTreeOfRoom() -> (){
    cBlack.child.append(secondTalk)
    cPurple.child.append(secondTalk)
    cBlue.child.append(secondTalk)
    rootNode.add(child: secondTalk)
}
