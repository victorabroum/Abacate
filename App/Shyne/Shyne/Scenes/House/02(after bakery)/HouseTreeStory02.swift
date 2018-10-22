//
//  HouseTreeStory02.swift
//  Shyne
//
//  Created by Ruy de Ascencão Neto on 22/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation


/////////Caminho 1
 var house02Root1: Node = Node(withText: NSLocalizedString("Por que você não trouxe o pão francês?", comment: ""), withChoices: [])

var house02Root1c1: Answer = Answer(withText: NSLocalizedString("O Padeiro se enganou.", comment: ""),withAmount: Feel(happy: 1, normal: 0.3, shy: 0), withChild: [])
// choice 2 -> d3_2
var house02Root1c2: Answer = Answer(withText: NSLocalizedString("Só tinha pão doce.", comment: ""), withAmount: Feel(happy: 0, normal: 0.5, shy: 0.1), withChild: [])
// choice 3 -> d3_3
var house02Root1c3: Answer = Answer(withText: NSLocalizedString("Desculpe.", comment: ""), withAmount: Feel(happy: 0, normal: 0.2, shy: 1), withChild: [])


///////Caminho2


var house02Root2: Node = Node(withText: NSLocalizedString("E ai meu filho como vai a faculdade?", comment: ""), withChoices: [])

var house02Root2c1: Answer = Answer(withText: NSLocalizedString("Estou com dificuldade de fazer amigos.", comment: ""),withAmount: Feel(happy: 1, normal: 0.3, shy: 0), withChild: [])
// choice 2 -> d3_2
var house02Root2c2: Answer = Answer(withText: NSLocalizedString("Tá meio pesado, mas vou levando.", comment: ""), withAmount: Feel(happy: 0, normal: 0.5, shy: 0.1), withChild: [])
// choice 3 -> d3_3
var house02Root2c3: Answer = Answer(withText: NSLocalizedString("Normal.", comment: ""), withAmount: Feel(happy: 0, normal: 0.2, shy: 1), withChild: [])


func house02makeTree(){
    house02Root1.choices.append(house02Root1c1)
    house02Root1.choices.append(house02Root1c2)
    house02Root1.choices.append(house02Root1c3)

    house02Root2.choices.append(house02Root2c1)
    house02Root2.choices.append(house02Root2c2)
    house02Root2.choices.append(house02Root2c3)
}
