//
//  PadariaTreeStory.swift
//  Shyne
//
//  Created by Nickson Kley Gonçalves Da Silva on 18/10/2018.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation
////Cena da Padaria
////D1->D2
//var textForRootPadaria: String = "Can I have some \nfrench bread, please?"
//var rootNodePadaria: Node = Node(withText: textForRootPadaria, withChoices: [],inNodeNamed:"playerNode")
////D2->D3
//var textSecondTalkPadaria : String = "Here's your sweet bread!"
//var secondTalkPadaria: Node = Node(withText: textSecondTalkPadaria, withChoices: [],inNodeNamed:"padeiroCaixa")
////D3->End
//var textThirdTalkPadaria : String = "Actually..."
//var rObrigado = Answer(withText: "...T...Thanks", withAmount: Feel(happy: 0, normal: 0, shy: 1.0))
//var rVcErrou = Answer(withText: "I think you made a mistake...", withAmount: Feel(happy: 0.5, normal: 0.5, shy: 0))
//var rVcErrouDeNovo = Answer(withText: "..But I ordered \nfrench bread!", withAmount: Feel(happy: 0.5, normal: 0.5, shy: 0))
//var thirdTalkPadaria: Node = Node(withText: textThirdTalkPadaria, withChoices:[rObrigado,rVcErrou,rVcErrouDeNovo],inNodeNamed:"playerNode")
//
//var bakery01D3 = Node(withText: NSLocalizedString("My bad, here's\n your french bread!", comment: ""), withChoices: [], inNodeNamed: "padeiroCaixa")
//
//var bakery01D4 = Node(withText: "That's ok,\n thank you!", withChoices: [], inNodeNamed: "playerNode")

var bakery01PlayerNameNode = "playerNode"
var bakery01BakerNameNode = "padeiroCaixa"

var bakery01Root = Node(withText: NSLocalizedString("Opa!", comment: ""), withChoices: [], inNodeNamed: bakery01BakerNameNode, audioName: "bakery_Snoring01")

var bakery01d02 = Node(withText: NSLocalizedString("Desculpe. O que você deseja", comment: ""), withChoices: [], inNodeNamed: bakery01BakerNameNode, audioName: "bakery_Voice03")
var bakery01d03 = Node(withText: NSLocalizedString("Me veja um real de pão francês", comment: ""), withChoices: [], inNodeNamed: bakery01PlayerNameNode, audioName: "felipe_Voice05")//Acao de trazer o pao
var bakery01d04 = Node(withText: NSLocalizedString("Aqui está o seu um\nreal de pão doce ", comment: ""), withChoices: [], inNodeNamed: bakery01BakerNameNode, audioName: "bakery_Voice01")

    var bakery01c01d04 = Answer(withText: NSLocalizedString("Ficar olhando\naté ele trocar", comment: ""), withAmount: Feel(happy: 0, normal: 1, shy: 0))
        var bakery01d01c01d04 = Node(withText: "...", withChoices: [], inNodeNamed: bakery01BakerNameNode, audioName: "bakery_Sigh01")
    var bakery01c02d04 = Answer(withText: NSLocalizedString("Pedir para ele\ntrocar o pão", comment: ""), withAmount: Feel(happy: 2, normal: 0, shy: 0))

        var bakery01d01c02d04 = Node(withText: NSLocalizedString("Moço eu pedi pão francês", comment: ""), withChoices: [], inNodeNamed: bakery01PlayerNameNode, audioName: "felipe_Voice01")

    var bakery01c03d04 = Answer(withText: NSLocalizedString("Levar o pão doce", comment: ""), withAmount: Feel(happy: 0, normal: 0, shy: 1))//chave do pao doce idle padeiro

var bakery01d05 = Node(withText: NSLocalizedString("Desculpe. Vou trazer o certo", comment: ""), withChoices: [], inNodeNamed: bakery01PlayerNameNode, audioName: "bakery_Voice02")//acao de trazer outro

var bakery01d06 = Node(withText: NSLocalizedString("Aqui está!\nPerdão pelo erro", comment: ""), withChoices: [], inNodeNamed: bakery01BakerNameNode, audioName: "bakery_Voice01")//idle

var bakery01d07 = Node(withText: NSLocalizedString("Ok", comment: ""), withChoices: [], inNodeNamed: bakery01PlayerNameNode, audioName: "felipe_Voice03")//chave do pao frances

func makeTreeOfRoomPadaria() -> (){
    
//    rootNodePadaria.add(child: secondTalkPadaria)
//    secondTalkPadaria.add(child: thirdTalkPadaria)
//
//    rVcErrou.child = [bakery01D3]
//    rVcErrouDeNovo.child = [bakery01D3]
//
//    bakery01D3.add(child: bakery01D4)
    
    bakery01Root.add(child: bakery01d02)
    bakery01d02.add(child: bakery01d03)
    bakery01d03.add(child: bakery01d04)
    
    bakery01d04.choices = [bakery01c01d04, bakery01c02d04,bakery01c03d04]
    
    bakery01c01d04.child = [bakery01d01c01d04]
    bakery01d01c01d04.add(child: bakery01d05)
    
    bakery01c02d04.child = [bakery01d01c02d04]
    bakery01d01c02d04.add(child: bakery01d05)
    
    bakery01d05.add(child: bakery01d06)
    bakery01d06.add(child: bakery01d07)
    
}
