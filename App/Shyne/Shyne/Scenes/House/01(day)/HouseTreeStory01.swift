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
//var house01Root: Node = Node(withText: NSLocalizedString("Morning, kiddo.", comment: ""), withChoices: [], inNodeNamed: "dad")
//
//// D2
//// choice 1 -> d3_1
//var c1: Answer = Answer(withText: NSLocalizedString("Ok, leave \nit to me!", comment: ""),withAmount: Feel(happy: 1, normal: 0.3, shy: 0), withChild: [])
//// choice 2 -> d3_2
//var c2: Answer = Answer(withText: NSLocalizedString("But I'm not \nhungry, dad..", comment: ""), withAmount: Feel(happy: 0, normal: 0.5, shy: 0.1), withChild: [])
//// choice 3 -> d3_3
//var c3: Answer = Answer(withText: NSLocalizedString("I don't wanna go there, \nit's too crowded!", comment: ""), withAmount: Feel(happy: 0, normal: 0.2, shy: 1), withChild: [])
//var d2: Node = Node(withText: NSLocalizedString("Could you get us some\n french bread from the bakery?", comment: "Pedido para comprar um tipo específico de pão"), withChoices: [c1, c2, c3], inNodeNamed: "dad")
//
//// D3 tem três versões possíveis -> End
//var d3_1: Node = Node(withText: NSLocalizedString("Thanks, here's\n the money.", comment: "Pai respondendo o filho"), withChoices: [], inNodeNamed: "dad")
//var d3_2: Node = Node(withText: NSLocalizedString("Well I am, just go!", comment: "Pai respondendo o filho"), withChoices: [], inNodeNamed: "dad")
//var d3_3: Node = Node(withText: NSLocalizedString("Don't be shy!\nJust go, please!", comment: "Pai respondendo o filho"), withChoices: [], inNodeNamed: "dad")

var house01PlayerNameNode = "playerNode"
var house01DadNameNode = "dadDialog"

var house01Root = Node(withText: NSLocalizedString("Bom dia, pai", comment: ""), withChoices: [], inNodeNamed: house01PlayerNameNode, audioName: "felipe_Voice04")
var house01d02 = Node(withText: NSLocalizedString("Bom dia, filho", comment: ""), withChoices: [], inNodeNamed: house01DadNameNode, audioName: "father_Voice01")
var house01d03 = Node(withText: NSLocalizedString("Já fiz o café,\nmas não tem pão.\nVocê pode ir comprar?", comment: ""), withChoices: [], inNodeNamed: house01DadNameNode, audioName: "father_voice02")

var house01c01d03 = Answer(withText: NSLocalizedString("Claro", comment: "Concerteza. no sentido de 'sim'"), withAmount: Feel(happy: 1, normal: 0, shy: 0), audioName: "felipe_voice02")
var house01c02d03 = Answer(withText: NSLocalizedString("Eu não estou com fome.", comment: ""), withAmount: Feel(happy: 0, normal: 1, shy: 2), audioName: "felipe_Voice01")

var house01d01c02d03 = Node(withText: NSLocalizedString("Mas eu estou.", comment: ""), withChoices: [], inNodeNamed: house01DadNameNode, audioName: "father_Voice03")
var house01d02c02d03 = Node(withText: NSLocalizedString("Ok. Já estou indo", comment: ""), withChoices: [], inNodeNamed: house01PlayerNameNode, audioName: "felipe_Voice05")

var house01c03d03 = Answer(withText: NSLocalizedString("Acena com\na cabeça", comment: ""), withAmount: Feel(happy: 0, normal: 2, shy: 0))

var house01d04 = Node(withText: NSLocalizedString("Ok.\nTrás pão francês", comment: ""), withChoices: [], inNodeNamed: house01DadNameNode, audioName: "father_Voice02")

func house01makeTree() -> (){
//    c1.child.append(d3_1)
//    c2.child.append(d3_2)
//    c3.child.append(d3_3)
//
//    house01Root.add(child: d2)
    
    house01Root.add(child: house01d02)
    house01d02.add(child: house01d03)
    house01d03.choices = [house01c03d03, house01c01d03, house01c02d03]
    
    house01c01d03.child = [house01d04]
    
    house01c02d03.child = [house01d01c02d03]
    house01d01c02d03.add(child: house01d02c02d03)
    house01d02c02d03.add(child: house01d04)
    
    house01c03d03.child = [house01d04]
}
