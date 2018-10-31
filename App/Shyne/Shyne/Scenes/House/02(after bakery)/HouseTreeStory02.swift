//
//  HouseTreeStory02.swift
//  Shyne
//
//  Created by Ruy de Ascencão Neto on 22/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation


/////////Caminho 1
 var house02Root1: Node = Node(withText: NSLocalizedString("Por que você não\n trouxe o pão francês?", comment: ""), withChoices: [], inNodeNamed: "dad")

var house02Root1c1: Answer = Answer(withText: NSLocalizedString("O padeiro se enganou, pai..", comment: ""),withAmount: Feel(happy: 1, normal: 0.3, shy: 0), withChild: [house02Root2])
// choice 2 -> d3_2
var house02Root1c2: Answer = Answer(withText: NSLocalizedString("Só tinha pão doce.", comment: ""), withAmount: Feel(happy: 0, normal: 0.5, shy: 0.1), withChild: [house02Root2])
// choice 3 -> d3_3
var house02Root1c3: Answer = Answer(withText: NSLocalizedString("Desculpe", comment: ""), withAmount: Feel(happy: 0, normal: 0.2, shy: 1), withChild: [house02Root2])


///////Caminho2


var house02Root2: Node = Node(withText: NSLocalizedString("E ai meu filho\ncomo vai a faculdade?", comment: ""), withChoices: [], inNodeNamed: "dad")

var house02Root2c1: Answer = Answer(withText: NSLocalizedString("Estou com dificuldade\n de fazer amigos.", comment: ""),withAmount: Feel(happy: 1, normal: 0.3, shy: 0), withChild: [dHouse02Dadc1])
// choice 2 -> d3_2
var house02Root2c2: Answer = Answer(withText: NSLocalizedString("Tá meio pesado,\nmas vou levando.", comment: ""), withAmount: Feel(happy: 0, normal: 0.5, shy: 0.1), withChild: [dHouse02Dadc2])
// choice 3 -> d3_3
var house02Root2c3: Answer = Answer(withText: NSLocalizedString("Normal.", comment: ""), withAmount: Feel(happy: 0, normal: 0.2, shy: 1), withChild: [dHouse02Dadc3])

var dHouse02Dadc1 = Node(withText: NSLocalizedString("Essas coisas são\nassim mesmo filho", comment: ""), withChoices: [], inNodeNamed: "dad")
var dHouse02Dadc2 = Node(withText: NSLocalizedString("Se esforce mais,\n você consegue", comment: ""), withChoices: [], inNodeNamed: "dad")
var dHouse02Dadc3 = Node(withText: NSLocalizedString("Hum...", comment: ""), withChoices: [], inNodeNamed: "dad")

var dHouse02Player1 = Node(withText: NSLocalizedString("Pois é, já \nestou atrasado", comment: ""), withChoices: [], inNodeNamed: "playerNode")
var dHouse02Player2 = Node(withText: NSLocalizedString("Tenho que ir\npara faculdade", comment: ""), withChoices: [], inNodeNamed: "playerNode")

var dHouse02Dadc4 = Node(withText: NSLocalizedString("Até de noite filho", comment: ""), withChoices: [], inNodeNamed: "dad")

var dHouse02Player3 = Node(withText: NSLocalizedString("Até mais, pai", comment: ""), withChoices: [], inNodeNamed: "playerNode")

func house02makeTree(){
    house02Root1.choices.append(house02Root1c1)
    house02Root1.choices.append(house02Root1c2)
    house02Root1.choices.append(house02Root1c3)

    house02Root2.choices.append(house02Root2c1)
    house02Root2.choices.append(house02Root2c2)
    house02Root2.choices.append(house02Root2c3)
    
    dHouse02Dadc1.childrens.append(dHouse02Player1)
    dHouse02Dadc2.childrens.append(dHouse02Player1)
    dHouse02Player1.childrens.append(dHouse02Player2)
    dHouse02Dadc3.childrens.append(dHouse02Player2)
    dHouse02Player2.childrens.append(dHouse02Dadc4)
    dHouse02Dadc4.childrens.append(dHouse02Player3)
    
}
