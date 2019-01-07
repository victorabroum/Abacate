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
var rootNode: Node = Node(withText: "Hoje parece que \nvai ser frio..", withChoices: [])

// D2
var secondTalk: Node = Node(withText: "Queria não ter que\nir para a faculdade", withChoices: [])

var fc1: Answer = Answer(withText: NSLocalizedString("Tudo bem,\ndeixe comigo!", comment: ""),withAmount: Feel(happy: 1, normal: 0.3, shy: 0), withChild: [])
// choice 2 -> d3_2
var fc2: Answer = Answer(withText: NSLocalizedString("Mas eu não estou \ncom fome, pai..", comment: ""), withAmount: Feel(happy: 0, normal: 0.5, shy: 0.1), withChild: [])
// choice 3 -> d3_3
var fc3: Answer = Answer(withText: NSLocalizedString("Não quero ir pai,\ntem muita gente lá!", comment: ""), withAmount: Feel(happy: 0, normal: 0.2, shy: 1), withChild: [])

//D3
var terceiraTalk = Node(withText: "Tô com fome..", withChoices: [fc1, fc2, fc3])

//D4
var quartaTalk = Node(withText: "Melhor eu descer\n para comer", withChoices: [])






// Construindo o fluxo
func makeTreeOfRoom() -> (){
    
    fc1.child.append(quartaTalk)
    fc2.child.append(quartaTalk)
    fc3.child.append(quartaTalk)
    
    rootNode.add(child: secondTalk)
    secondTalk.add(child: terceiraTalk)
//    terceiraTalk.add(child: quartaTalk)
}
