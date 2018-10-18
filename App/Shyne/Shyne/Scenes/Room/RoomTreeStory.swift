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
var cBlack: Answer = Answer(withText: "Preto")
var cPurple: Answer = Answer(withText: "Roxo")
var cBlue: Answer = Answer(withText: "Azul")
var rootNode: Node = Node(withText: textForRoot, withChoices: [cBlack, cPurple, cBlue])

// D2 -> End
var textSecondTalk: String = "Então vai ser esse!"
var secondTalk: Node = Node(withText: textSecondTalk, withChoices: [])

// Construindo o fluxo
func makeTreeOfRoom() -> (){
    rootNode.add(child: secondTalk)
}
