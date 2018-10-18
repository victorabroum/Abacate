//
//  PadariaTreeStory.swift
//  Shyne
//
//  Created by Nickson Kley Gonçalves Da Silva on 18/10/2018.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation
//Cena da Padaria
//D1->D2
var textForRootPadaria: String = "Me veja um pão doce"
var rootNodePadaria: Node = Node(withText: textForRootPadaria, withChoices: [])
//D2->D3
var textSecondTalkPadaria : String = "Aqui está seu pão doce!"
var secondTalkPadaria: Node = Node(withText: textSecondTalkPadaria, withChoices: [])
//D3->End
var textThirdTalkPadaria : String = "É q...."
var rObrigado = Answer(withText: "...O...Obrigado", withAmount: Feel(happy: 0, normal: 0, shy: 1.0))
var rVcErrou = Answer(withText: "Acho que o senhor se enganou...", withAmount: Feel(happy: 0.5, normal: 0.5, shy: 0))
var thirdTalkPadaria: Node = Node(withText: textThirdTalkPadaria, withChoices:[rObrigado,rVcErrou])

func makeTreeOfRoomPadaria() -> (){
    rootNodePadaria.add(child: secondTalkPadaria)
    secondTalkPadaria.add(child: thirdTalkPadaria)
}
