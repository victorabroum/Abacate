//
//  HouseTreeStory02.swift
//  Shyne
//
//  Created by Ruy de Ascencão Neto on 22/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation


/////////Caminho 1
 var house02Root1: Node = Node(withText: NSLocalizedString("Why didn't you\n get the french bread?", comment: ""), withChoices: [], inNodeNamed: "dad")

var house02Root1c1: Answer = Answer(withText: NSLocalizedString("The baker made \na mistake, dad..", comment: ""),withAmount: Feel(happy: 1, normal: 0.3, shy: 0), withChild: [house02Root2])
// choice 2 -> d3_2
var house02Root1c2: Answer = Answer(withText: NSLocalizedString("They were out of french bread.", comment: ""), withAmount: Feel(happy: 0, normal: 0.5, shy: 0.1), withChild: [house02Root2])
// choice 3 -> d3_3
var house02Root1c3: Answer = Answer(withText: NSLocalizedString("I'm sorry...", comment: ""), withAmount: Feel(happy: 0, normal: 0.2, shy: 1), withChild: [house02Root2])


///////Caminho2


var house02Root2: Node = Node(withText: NSLocalizedString("So kiddo,\nhow's school?", comment: ""), withChoices: [], inNodeNamed: "dad")

var house02Root2c1: Answer = Answer(withText: NSLocalizedString("I'm having a hard\n time making friends.", comment: ""),withAmount: Feel(happy: 1, normal: 0.3, shy: 0), withChild: [dHouse02Dadc1])
// choice 2 -> d3_2
var house02Root2c2: Answer = Answer(withText: NSLocalizedString("Kinda harsh,\nbut I'm getting by.", comment: ""), withAmount: Feel(happy: 0, normal: 0.5, shy: 0.1), withChild: [dHouse02Dadc2])
// choice 3 -> d3_3
var house02Root2c3: Answer = Answer(withText: NSLocalizedString("Normal.", comment: ""), withAmount: Feel(happy: 0, normal: 0.2, shy: 1), withChild: [dHouse02Dadc3])

var dHouse02Dadc1 = Node(withText: NSLocalizedString("You know, these \nthings are hard..", comment: ""), withChoices: [], inNodeNamed: "dad")
var dHouse02Dadc2 = Node(withText: NSLocalizedString("Make an effort,\n you've got this!", comment: ""), withChoices: [], inNodeNamed: "dad")
var dHouse02Dadc3 = Node(withText: NSLocalizedString("Hum...", comment: ""), withChoices: [], inNodeNamed: "dad")

var dHouse02Player1 = Node(withText: NSLocalizedString("Yeah... \nI better get going.", comment: ""), withChoices: [], inNodeNamed: "playerNode")
var dHouse02Player2 = Node(withText: NSLocalizedString("My class is \nabout to start.", comment: ""), withChoices: [], inNodeNamed: "playerNode")

var dHouse02Dadc4 = Node(withText: NSLocalizedString("See you later, kiddo.", comment: ""), withChoices: [], inNodeNamed: "dad")

var dHouse02Player3 = Node(withText: NSLocalizedString("Later, dad.", comment: ""), withChoices: [], inNodeNamed: "playerNode")

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
