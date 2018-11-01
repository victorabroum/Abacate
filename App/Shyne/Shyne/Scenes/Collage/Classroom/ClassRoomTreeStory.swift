//
//  ClassRoomTreeStory.swift
//  Shyne
//
//  Created by Ruy de Ascencão Neto on 22/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation
import GameplayKit

var classRoomRoot: Node = Node(withText: NSLocalizedString("Então pessoal,\n fechamos mais\n um assunto.", comment: ""), withChoices: [],inNodeNamed:"professora")

var classRoom01D1: Node = Node(withText: NSLocalizedString("Formem grupos\nde até 4 pessoas", comment: ""), withChoices: [],inNodeNamed:"professora")

var classRoom01D2: Node = Node(withText: NSLocalizedString("Teremos uma \napresentação daqui\n a 5 dias.", comment: ""), withChoices: [],inNodeNamed:"professora")

var classRoomRootc1: Answer = Answer(withText: NSLocalizedString("Vou criar minha\n propria equipe.", comment: ""),withAmount: Feel(happy: 1, normal: 0.3, shy: 0), withChild: [class01Player01])

var classRoomRootc2: Answer = Answer(withText: NSLocalizedString("Vou para a \nequipe do Ruy.", comment: ""), withAmount: Feel(happy: 0, normal: 0.5, shy: 0.1), withChild: [class01Player01])

var classRoomRootc3: Answer = Answer(withText: NSLocalizedString("Vou esperar \nme escolherem.", comment: ""), withAmount: Feel(happy: 0, normal: 0.2, shy: 1), withChild: [class01Player03])


var class01Player01 = Node(withText: NSLocalizedString("Beleza, amanhã \nresolvo isso!", comment: ""), withChoices: [], inNodeNamed: "playerNode")

var class01Player02 = Node(withText: NSLocalizedString("Agora vou é para casa.", comment: ""), withChoices: [], inNodeNamed: "playerNode")

var class01Player03 = Node(withText: NSLocalizedString("Putz, ninguém vai me escolher", comment: ""), withChoices: [], inNodeNamed: "playerNode")

var class01Player04 = Node(withText: NSLocalizedString("Tudo bem eu\nfaço sozinho", comment: ""), withChoices: [], inNodeNamed: "playerNode")


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
