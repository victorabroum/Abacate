//
//  ClassRoomTreeStory.swift
//  Shyne
//
//  Created by Ruy de Ascencão Neto on 22/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation
import GameplayKit

var classRoomRoot: Node = Node(withText: NSLocalizedString("Formem grupos de até 4 pessoas", comment: ""), withChoices: [],inNodeNamed:"professora")

var classRoomRootc1: Answer = Answer(withText: NSLocalizedString("Vou criar minha propria equipe.", comment: ""),withAmount: Feel(happy: 1, normal: 0.3, shy: 0), withChild: [])

var classRoomRootc2: Answer = Answer(withText: NSLocalizedString("Vou para a equipe do Ruy.", comment: ""), withAmount: Feel(happy: 0, normal: 0.5, shy: 0.1), withChild: [])

var classRoomRootc3: Answer = Answer(withText: NSLocalizedString("Vou esperar me escolherem.", comment: ""), withAmount: Feel(happy: 0, normal: 0.2, shy: 1), withChild: [])


func classRoomRootmakeTree(){
    classRoomRoot.choices.append(classRoomRootc1)
    classRoomRoot.choices.append(classRoomRootc2)
    classRoomRoot.choices.append(classRoomRootc3)
}
