//
//  HouseTreeStory03.swift
//  Shyne
//
//  Created by Nickson Kley Gonçalves Da Silva on 30/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation

// D1
var house03Root = Node(withText: "Evening, dad!", withChoices: [])

//D2
var house03_D2 = Node(withText: "Evening, kiddo", withChoices: [], inNodeNamed: "Dad")

//D3
var house03_C1 = Answer(withText: "Tiring, actually.\nI think i'll crash.", withAmount: Feel(happy: 0, normal: 1, shy: 0), withChild: [house03_D4_1])
var house03_C2 = Answer(withText: "Nothing new.", withAmount: Feel(happy: 0, normal: 0, shy: 1), withChild: [house03_D4_2])
var house03_C3 = Answer(withText: "I've got a big\n project coming\n up in 5 days", withAmount: Feel(happy: 1, normal: 0.3, shy: 0), withChild: [house03_D4_2])
var house03_D3 = Node(withText: "How was\n school?", withChoices: [house03_C1,house03_C3,house03_C2], inNodeNamed: "Dad")

//D4_1
var house03_D4_1 = Node(withText: "I'll go to my room", withChoices: [])

//D4_2
var house03_D4_2 = Node(withText: "I see. Come\n have some dinner", withChoices: [], inNodeNamed: "Dad")

//D5
var house03_D5 = Node(withText: "See you tomorrow,\n good night", withChoices: [])

func house03makeTree()->(){
    house03Root.add(child: house03_D2)
    house03_D2.add(child: house03_D3)
    house03_D4_2.add(child: house03_D4_1)
    house03_D4_1.add(child: house03_D5)
}
