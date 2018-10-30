//
//  HouseTreeStory03.swift
//  Shyne
//
//  Created by Nickson Kley Gonçalves Da Silva on 30/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation

// D1
var house03Root = Node(withText: "Boa Noite Pai!", withChoices: [])

//D2
var house03_D2 = Node(withText: "Boa noite filho", withChoices: [], inNodeNamed: "Dad")

//D3
var house03_C1 = Answer(withText: "Cansativa pai,\nacho que já vou dormir", withAmount: Feel(happy: 0, normal: 1, shy: 0), withChild: [house03_D4_1])
var house03_C2 = Answer(withText: "Tudo na mesma", withAmount: Feel(happy: 0, normal: 0, shy: 1), withChild: [house03_D4_2])
var house03_C3 = Answer(withText: "Tenho um megatrabalho\n para daqui 5 dias", withAmount: Feel(happy: 1, normal: 0.3, shy: 0), withChild: [house03_D4_2])
var house03_D3 = Node(withText: "Como foi\na faculdade?", withChoices: [house03_C1,house03_C2,house03_C3], inNodeNamed: "Dad")

//D4_1
var house03_D4_1 = Node(withText: "Vou pro meu quarto", withChoices: [])

//D4_2
var house03_D4_2 = Node(withText: "Entendo, venha jantar", withChoices: [], inNodeNamed: "Dad")

//D5
var house03_D5 = Node(withText: "Até amanhã, boa noite", withChoices: [])

func house03makeTree()->(){
    house03Root.add(child: house03_D2)
    house03_D2.add(child: house03_D3)
    house03_D4_2.add(child: house03_D4_1)
    house03_D4_1.add(child: house03_D5)
}
