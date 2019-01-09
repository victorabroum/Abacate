//
//  HouseTreeStory01.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 19/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation

// Cena da casa, de manhã, **antes** de ir para padaria

// D1 -> D2
//var house01Root: Node = Node(withText: NSLocalizedString("Bom dia filho!", comment: ""), withChoices: [])
var house01Root: Node = Node(withText: NSLocalizedString("Morning, kiddo.", comment: ""), withChoices: [], inNodeNamed: "dad")

// D2
// choice 1 -> d3_1
var c1: Answer = Answer(withText: NSLocalizedString("Ok, leave \nit to me!", comment: ""),withAmount: Feel(happy: 1, normal: 0.3, shy: 0), withChild: [])
// choice 2 -> d3_2
var c2: Answer = Answer(withText: NSLocalizedString("But I'm not \nhungry, dad..", comment: ""), withAmount: Feel(happy: 0, normal: 0.5, shy: 0.1), withChild: [])
// choice 3 -> d3_3
var c3: Answer = Answer(withText: NSLocalizedString("I don't wanna go there, \nit's too crowded!", comment: ""), withAmount: Feel(happy: 0, normal: 0.2, shy: 1), withChild: [])
var d2: Node = Node(withText: NSLocalizedString("Could you get us some\n french bread from the bakery?", comment: "Pedido para comprar um tipo específico de pão"), withChoices: [c1, c2, c3], inNodeNamed: "dad")

// D3 tem três versões possíveis -> End
var d3_1: Node = Node(withText: NSLocalizedString("Thanks, here's\n the money.", comment: "Pai respondendo o filho"), withChoices: [], inNodeNamed: "dad")
var d3_2: Node = Node(withText: NSLocalizedString("Well I am, just go!", comment: "Pai respondendo o filho"), withChoices: [], inNodeNamed: "dad")
var d3_3: Node = Node(withText: NSLocalizedString("Don't be shy!\nJust go, please!", comment: "Pai respondendo o filho"), withChoices: [], inNodeNamed: "dad")

func house01makeTree() -> (){
    c1.child.append(d3_1)
    c2.child.append(d3_2)
    c3.child.append(d3_3)
    
    house01Root.add(child: d2)
}
