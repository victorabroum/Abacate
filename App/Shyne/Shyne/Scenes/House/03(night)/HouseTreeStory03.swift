//
//  HouseTreeStory03.swift
//  Shyne
//
//  Created by Nickson Kley Gonçalves Da Silva on 30/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation

//// D1
//var house03Root = Node(withText: "Evening, dad!", withChoices: [])
//
////D2
//var house03_D2 = Node(withText: "Evening, kiddo.", withChoices: [], inNodeNamed: "Dad")
//
////D3
//var house03_C1 = Answer(withText: "Tiring, actually.\nI think i'll crash.", withAmount: Feel(happy: 0, normal: 1, shy: 0), withChild: [house03_D4_1])
//var house03_C2 = Answer(withText: "Nothing new.", withAmount: Feel(happy: 0, normal: 0, shy: 1), withChild: [house03_D4_2])
//var house03_C3 = Answer(withText: "I've got a big\n project coming\n up in 5 days.", withAmount: Feel(happy: 1, normal: 0.3, shy: 0), withChild: [house03_D4_2])
//var house03_D3 = Node(withText: "How was\n school?", withChoices: [house03_C1,house03_C3,house03_C2], inNodeNamed: "Dad")
//
////D4_1
//var house03_D4_1 = Node(withText: "I'm not that hungry.\nI'll go to my room.", withChoices: [])
//
////D4_2
//var house03_D4_2 = Node(withText: "I see.\n Come have\n some dinner.", withChoices: [], inNodeNamed: "Dad")
//
////D5
//var house03_D5 = Node(withText: "Good night dad, \nsee you tomorrow.", withChoices: [])

var house03PlayerNameNode = "playerNode"
var house03DadNameNode = "Dad"

var house03Root = Node(withText: NSLocalizedString("Boa noite, Filho", comment: ""), withChoices: [], inNodeNamed: house03DadNameNode, audioName: "father_Voice01")
var house03d02 = Node(withText: NSLocalizedString("Boa noite, pai", comment: ""), withChoices: [], inNodeNamed: house03PlayerNameNode, audioName: "felipe_Voice02")
var house03d03 = Node(withText: NSLocalizedString("Como foi seu dia?", comment: ""), withChoices: [], inNodeNamed: house03DadNameNode, audioName: "father_Voice02")

var house03SBTc01d03 = Answer(withText: "Lembrar do pão", withAmount: Feel(happy: 0, normal: 1, shy: 0))

var house03d01SBTc01d03 = Node(withText: NSLocalizedString("Tirando o pão doce", comment: ""), withChoices: [], inNodeNamed:house03PlayerNameNode, audioName: "felipe_Voice03")
var house03d02SBTc01d03 = Node(withText: NSLocalizedString("Esquece isso filho", comment: ""), withChoices: [], inNodeNamed: house03DadNameNode, audioName: "father_Voice03")//house03NTd05SBFc02d03 é filho

var house03SBFc02d03 = Answer(withText: "Normal", withAmount: Feel(happy: 0, normal: 0, shy: 1), audioName: "felipe_Voice01")

var house03NTd01SBFc02d03 = Node(withText: NSLocalizedString("Fala alguma coisa além de 'normal'", comment: ""), withChoices: [], inNodeNamed: house03DadNameNode, audioName: "father_voice02")
var house03NTd02SBFc02d03 = Node(withText: NSLocalizedString("Desculpa", comment: ""), withChoices: [], inNodeNamed: house03PlayerNameNode, audioName: "felipe_Voice01")
var house03NTd03SBFc02d03 = Node(withText: NSLocalizedString("Você fala tanto que podia ser radialista", comment: ""), withChoices: [], inNodeNamed: house03DadNameNode, audioName: "father_Laught02")//Se nao tiver chave normal o dialogo inicia aqui
var house03NTd04SBFc02d03 = Node(withText: NSLocalizedString("kkk", comment: ""), withChoices: [], inNodeNamed: house03PlayerNameNode, audioName: "felipe_Laught01")
var house03NTd05SBFc02d03 = Node(withText: NSLocalizedString("E a faculdade?", comment: ""), withChoices: [], inNodeNamed: house03DadNameNode, audioName: "father_Voice01")
var house03NTd06SBFc02d03 = Node(withText: NSLocalizedString("Tenho um trabalho muito importante ", comment: ""), withChoices: [], inNodeNamed: house03PlayerNameNode, audioName: "felipe_Voice01")

var house03SBFc03d03 = Answer(withText: "Tenho um trabalho muito importante para fazer", withAmount: Feel(happy: 1, normal: 0, shy: 1), audioName: "Felipe_Voice04")

var house03d04 = Node(withText: NSLocalizedString("Mas esse trabalho é grande?", comment: ""), withChoices: [], inNodeNamed: house03DadNameNode, audioName: "father_Voice03")
var house03d05 = Node(withText: NSLocalizedString("É, mas a ana vai me ajudar", comment: ""), withChoices: [], inNodeNamed: house03PlayerNameNode, audioName: "felipe_Voice03")
var house03d06 = Node(withText: NSLocalizedString("Sempre ela né!!", comment: ""), withChoices: [], inNodeNamed: house03DadNameNode, audioName: "father_Voice02")
var house03d07 = Node(withText: NSLocalizedString("OK, eu tenho que ir para o quarto", comment: ""), withChoices: [], inNodeNamed: house03PlayerNameNode, audioName: "felipe_Voice01")
var house03d08 = Node(withText: NSLocalizedString("OK filho", comment: ""), withChoices: [], inNodeNamed: house03DadNameNode, audioName: "father_Voice03")
var house03d09 = Node(withText: NSLocalizedString("Boa noite, pai", comment: ""), withChoices: [], inNodeNamed: house03PlayerNameNode, audioName: "felipe_Voice03")
var house03d10 = Node(withText: NSLocalizedString("Boa noite, filho", comment: ""), withChoices: [], inNodeNamed: house03DadNameNode, audioName: "father_Voice03")




func house03makeTree()->(){
//    house03Root.add(child: house03_D2)
//    house03_D2.add(child: house03_D3)
//    house03_D4_2.add(child: house03_D4_1)
//    house03_D4_1.add(child: house03_D5)
    house03Root.add(child: house03d02)
    house03d02.add(child: house03d03)
    //TODO: Colocar as choices do house03d03
    
    if(PlayerModel.getInstance().keys.contains("sweetBrad")){
        house03d03.choices = [house03SBTc01d03,house03SBFc02d03,house03SBFc03d03]
    }
    else{
        house03d03.choices = [house03SBFc02d03,house03SBFc03d03]
    }
    
    house03SBTc01d03.child = [house03d01SBTc01d03]
    house03d01SBTc01d03.add(child: house03d02SBTc01d03)
    house03d02SBTc01d03.add(child: house03NTd05SBFc02d03)
    
    //TODO: colocar o filho certo do house03SBFc02d03
    
    if(PlayerModel.getInstance().keys.contains("Normal")){
        house03SBFc02d03.child = [house03NTd01SBFc02d03]
    }
    else{
        house03SBFc02d03.child = [house03NTd03SBFc02d03]
    }
    
    house03NTd01SBFc02d03.add(child: house03NTd02SBFc02d03)
    house03NTd02SBFc02d03.add(child: house03NTd03SBFc02d03)
    house03NTd03SBFc02d03.add(child: house03NTd04SBFc02d03)
    house03NTd04SBFc02d03.add(child: house03NTd05SBFc02d03)
    house03NTd05SBFc02d03.add(child: house03NTd06SBFc02d03)
    house03NTd06SBFc02d03.add(child: house03d04)
    
    house03SBFc03d03.child = [house03d04]
    
    house03d04.add(child: house03d05)
    house03d05.add(child: house03d06)
    house03d06.add(child: house03d07)
    house03d07.add(child: house03d08)
    house03d08.add(child: house03d09)
    house03d09.add(child: house03d10)
    
}
