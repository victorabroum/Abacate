//
//  ClassRoomTreeStory.swift
//  Shyne
//
//  Created by Ruy de Ascencão Neto on 22/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation
import GameplayKit

var classRoomRoot: Node = Node(withText: NSLocalizedString("So with this, we \n finish another subject.", comment: ""), withChoices: [],inNodeNamed:"professora")

var classRoom01D1: Node = Node(withText: NSLocalizedString("Form groups\nof 4 people.", comment: ""), withChoices: [],inNodeNamed:"professora")

var classRoom01D2: Node = Node(withText: NSLocalizedString("We'll have a presentation \n 5 days from now.", comment: ""), withChoices: [],inNodeNamed:"professora")

var classRoomRootc1: Answer = Answer(withText: NSLocalizedString("I'll make my\n own team.", comment: ""),withAmount: Feel(happy: 1, normal: 0.3, shy: 0), withChild: [class01Player01])

var classRoomRootc2: Answer = Answer(withText: NSLocalizedString("I'll go to \nRuy's team.", comment: ""), withAmount: Feel(happy: 0, normal: 0.5, shy: 0.1), withChild: [class01Player01])

var classRoomRootc3: Answer = Answer(withText: NSLocalizedString("I'll wait for\n someone to pick me.", comment: ""), withAmount: Feel(happy: 0, normal: 0.2, shy: 1), withChild: [class01Player03])


var class01Player01 = Node(withText: NSLocalizedString("Alright, tomorrow \ni'll settle this!", comment: ""), withChoices: [], inNodeNamed: "playerNode")

var class01Player02 = Node(withText: NSLocalizedString("I getter get going now.", comment: ""), withChoices: [], inNodeNamed: "playerNode")

var class01Player03 = Node(withText: NSLocalizedString("Let's face it.. \nno one's gonna pick me.", comment: ""), withChoices: [], inNodeNamed: "playerNode")

var class01Player04 = Node(withText: NSLocalizedString("Alright, I'll\n do it by myself.", comment: ""), withChoices: [], inNodeNamed: "playerNode")


func classRoomRootmakeTree(){
    classRoomRoot.childrens = [classRoom01D2]
    
    classRoom01D2.childrens = [classRoom01D1]
    
    classRoom01D1.choices.append(classRoomRootc1)
    classRoom01D1.choices.append(classRoomRootc2)
    classRoom01D1.choices.append(classRoomRootc3)
    
    class01Player01.childrens.append(class01Player02)
    class01Player03.childrens.append(class01Player04)
    class01Player04.childrens.append(class01Player02)
    
}
