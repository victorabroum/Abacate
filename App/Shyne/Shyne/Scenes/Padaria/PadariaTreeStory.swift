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
var textForRootPadaria: String = "Can I have some \nfrench bread, please?"
var rootNodePadaria: Node = Node(withText: textForRootPadaria, withChoices: [],inNodeNamed:"playerNode")
//D2->D3
var textSecondTalkPadaria : String = "Here's your sweet bread!"
var secondTalkPadaria: Node = Node(withText: textSecondTalkPadaria, withChoices: [],inNodeNamed:"padeiroCaixa")
//D3->End
var textThirdTalkPadaria : String = "Actually..."
var rObrigado = Answer(withText: "...T...Thanks", withAmount: Feel(happy: 0, normal: 0, shy: 1.0))
var rVcErrou = Answer(withText: "I think you made a mistake...", withAmount: Feel(happy: 0.5, normal: 0.5, shy: 0))
var rVcErrouDeNovo = Answer(withText: "..But I ordered \nfrench bread!", withAmount: Feel(happy: 0.5, normal: 0.5, shy: 0))
var thirdTalkPadaria: Node = Node(withText: textThirdTalkPadaria, withChoices:[rObrigado,rVcErrou,rVcErrouDeNovo],inNodeNamed:"playerNode")

var bakery01D3 = Node(withText: NSLocalizedString("My bad, here's\n your french bread!", comment: ""), withChoices: [], inNodeNamed: "padeiroCaixa")

var bakery01D4 = Node(withText: "That's ok,\n thank you!", withChoices: [], inNodeNamed: "playerNode")

func makeTreeOfRoomPadaria() -> (){
    
    rootNodePadaria.add(child: secondTalkPadaria)
    secondTalkPadaria.add(child: thirdTalkPadaria)
    
    rVcErrou.child = [bakery01D3]
    rVcErrouDeNovo.child = [bakery01D3]
    
    bakery01D3.add(child: bakery01D4)
}
