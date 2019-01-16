//
//  HouseTreeStory02.swift
//  Shyne
//
//  Created by Ruy de Ascencão Neto on 22/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation

var house02Root3 = Node(withText: NSLocalizedString("French brad, kiddo!", comment: ""), withChoices: [], inNodeNamed: "dad")


///////////Caminho 1
// var house02Root1: Node = Node(withText: NSLocalizedString("Why didn't you\n get the french bread?", comment: ""), withChoices: [], inNodeNamed: "dad")
//
//var house02Root1c1: Answer = Answer(withText: NSLocalizedString("The baker made \na mistake, dad..", comment: ""),withAmount: Feel(happy: 1, normal: 0.3, shy: 0), withChild: [house02Root2])
//// choice 2 -> d3_2
//var house02Root1c2: Answer = Answer(withText: NSLocalizedString("They were out of french bread.", comment: ""), withAmount: Feel(happy: 0, normal: 0.5, shy: 0.1), withChild: [house02Root2])
//// choice 3 -> d3_3
//var house02Root1c3: Answer = Answer(withText: NSLocalizedString("I'm sorry...", comment: ""), withAmount: Feel(happy: 0, normal: 0.2, shy: 1), withChild: [house02Root2])
//
//
/////////Caminho2
//
//
//var house02Root2: Node = Node(withText: NSLocalizedString("So kiddo,\nhow's school?", comment: ""), withChoices: [], inNodeNamed: "dad")
//
//var house02Root2c1: Answer = Answer(withText: NSLocalizedString("I'm having a hard\n time making friends.", comment: ""),withAmount: Feel(happy: 1, normal: 0.3, shy: 0), withChild: [dHouse02Dadc1])
//// choice 2 -> d3_2
//var house02Root2c2: Answer = Answer(withText: NSLocalizedString("Kinda harsh,\nbut I'm getting by.", comment: ""), withAmount: Feel(happy: 0, normal: 0.5, shy: 0.1), withChild: [dHouse02Dadc2])
//// choice 3 -> d3_3
//var house02Root2c3: Answer = Answer(withText: NSLocalizedString("Normal.", comment: ""), withAmount: Feel(happy: 0, normal: 0.2, shy: 1), withChild: [dHouse02Dadc3])
//
//var dHouse02Dadc1 = Node(withText: NSLocalizedString("You know, these \nthings are hard..", comment: ""), withChoices: [], inNodeNamed: "dad")
//var dHouse02Dadc2 = Node(withText: NSLocalizedString("Make an effort,\n you've got this!", comment: ""), withChoices: [], inNodeNamed: "dad")
//var dHouse02Dadc3 = Node(withText: NSLocalizedString("Hum...", comment: ""), withChoices: [], inNodeNamed: "dad")
//
//var dHouse02Player1 = Node(withText: NSLocalizedString("Yeah... \nI better get going.", comment: ""), withChoices: [], inNodeNamed: "playerNode")
//var dHouse02Player2 = Node(withText: NSLocalizedString("My class is \nabout to start.", comment: ""), withChoices: [], inNodeNamed: "playerNode")
//
//var dHouse02Dadc4 = Node(withText: NSLocalizedString("See you later, kiddo.", comment: ""), withChoices: [], inNodeNamed: "dad")
//
//var dHouse02Player3 = Node(withText: NSLocalizedString("Later, dad.", comment: ""), withChoices: [], inNodeNamed: "playerNode")

var house02PlayerNameNode = "playerNode"
var house02DadNameNode = "dad"

var house02RootDoce = Node(withText: NSLocalizedString("Filho.", comment: ""), withChoices: [], inNodeNamed: house02DadNameNode, audioName: "father_Laught01")
var house02d02Doce = Node(withText: NSLocalizedString("Eu não pedi pão francês?", comment: ""), withChoices: [], inNodeNamed: house02DadNameNode, audioName: "father_Laught02")
var house02d03Doce = Node(withText: NSLocalizedString("Sim.", comment: ""), withChoices: [], inNodeNamed: house02PlayerNameNode, audioName: "felipe_Voice03")
var house02d04Doce = Node(withText: NSLocalizedString("Então?", comment: ""), withChoices: [], inNodeNamed: house02DadNameNode, audioName: "father_Laught03")

var house02c01d04Doce = Answer(withText: NSLocalizedString("Só tinha\npão doce", comment: ""), withAmount: Feel(happy: 0, normal: 0, shy: 1), audioName: "felipe_Voice01")
var house02c02d04Doce = Answer(withText: NSLocalizedString("Culpar o\npadeiro", comment: ""), withAmount: Feel(happy: 0, normal: 0, shy: 2))

var house02d01c02d04Doce = Node(withText: NSLocalizedString("O padeiro que me deu errado.", comment: ""), withChoices: [], inNodeNamed: house02PlayerNameNode, audioName: "felipe_Voice02")
var house02d02c02d04Doce = Node(withText: NSLocalizedString("Era só pedir para ele trocar.", comment: ""), withChoices: [], inNodeNamed: house02DadNameNode, audioName: "father_Voice02")
var house02d03c02d04Doce = Node(withText: NSLocalizedString("Desculpa, pai.", comment: ""), withChoices: [], inNodeNamed: house02PlayerNameNode, audioName: "felipe_Voice03")

var house02c03d04Doce = Answer(withText: "Desculpa", withAmount: Feel(happy: 1, normal: 0, shy: 0), audioName: "felipe_Voice03")

var house02d05Doce = Node(withText: NSLocalizedString("Enfim...", comment: ""), withChoices: [], inNodeNamed: house02DadNameNode, audioName: "father_Voice01")

var house02RootNormal = Node(withText: NSLocalizedString("Sente, e vamos comer.", comment: ""), withChoices: [], inNodeNamed: house02DadNameNode, audioName: "father_Voice03")//transicao para ele sentando

var house02d02 = Node(withText: NSLocalizedString("Como tá a faculdade?", comment: ""), withChoices: [], inNodeNamed: house02DadNameNode, audioName: "father_Voice02")

var house02c01d02 = Answer(withText: NSLocalizedString("Normal", comment: ""), withAmount: Feel(happy: 0, normal: 1, shy: 0), audioName: "felipe_Voice02")//paga a key normal
var house02c02d02 = Answer(withText: "Tá difícil,\nmas estou levando", withAmount: Feel(happy: 1, normal: 0, shy: 0), audioName: "felipe_Voice01")

var house02d01c02d02 = Node(withText: NSLocalizedString("Eu não sei como ajudar.", comment: ""), withChoices: [], inNodeNamed: house02DadNameNode, audioName: "father_Voice01")
var house02d02c02d02 = Node(withText: NSLocalizedString("Mas então...\nTá gostando de alguém?", comment: ""), withChoices: [], inNodeNamed: house02DadNameNode, audioName: "father_Voice03")
var house02d03c02d02 = Node(withText: NSLocalizedString("", comment: ""), withChoices: [], inNodeNamed: house02PlayerNameNode, audioName: "")//icone da ana
var house02d04c02d02 = Node(withText: NSLocalizedString("Não, não.", comment: ""), withChoices: [], inNodeNamed: house02PlayerNameNode, audioName: "felipe_Voice05")

var house02c03d02 = Answer(withText: "Tentar trocar\nde assunto", withAmount: Feel(happy: 0, normal: 0, shy: 1))

var house02d01c03d02 = Node(withText: NSLocalizedString("O senhor já regou suas plantas?", comment: ""), withChoices: [], inNodeNamed: house02PlayerNameNode, audioName: "felipe_Voice02")
var house02d02c03d02 = Node(withText: NSLocalizedString("Se o senhor não regá-las,\n elas vão morrer.", comment: ""), withChoices: [], inNodeNamed: house02PlayerNameNode, audioName: "felipe_Voice01")
var house02d03c03d02 = Node(withText: NSLocalizedString("Ele vai esquecer.", comment: ""), withChoices: [], inNodeNamed: house02PlayerNameNode, audioName: "")

var house02d03 = Node(withText: NSLocalizedString(" . . . ", comment: ""), withChoices: [], inNodeNamed: house02PlayerNameNode, audioName: "felipe_Voice02")
var house02d04 = Node(withText: NSLocalizedString("Tenho que ir para a faculdade, pai.", comment: ""), withChoices: [], inNodeNamed: house02PlayerNameNode, audioName: "felipe_Voice01")
var house02d05 = Node(withText: NSLocalizedString("Tchau! Quando chegar lá me avisa.", comment: ""), withChoices: [], inNodeNamed: house02DadNameNode, audioName: "father_Voice01")
var house02d06 = Node(withText: NSLocalizedString("Ta, pai.", comment: ""), withChoices: [], inNodeNamed: house02PlayerNameNode, audioName: "felipe_Voice02")

func house02makeTree(){
//    house02Root1.choices.append(house02Root1c1)
//    house02Root1.choices.append(house02Root1c2)
//    house02Root1.choices.append(house02Root1c3)
//
//    house02Root2.choices.append(house02Root2c1)
//    house02Root2.choices.append(house02Root2c2)
//    house02Root2.choices.append(house02Root2c3)
//    
//    dHouse02Dadc1.childrens.append(dHouse02Player1)
//    dHouse02Dadc2.childrens.append(dHouse02Player1)
//    dHouse02Player1.childrens.append(dHouse02Player2)
//    dHouse02Dadc3.childrens.append(dHouse02Player2)
//    dHouse02Player2.childrens.append(dHouse02Dadc4)
//    dHouse02Dadc4.childrens.append(dHouse02Player3)
    
    house02RootDoce.add(child: house02d02Doce)
    house02d02Doce.add(child: house02d03Doce)
    house02d03Doce.add(child: house02d04Doce)
    house02d04Doce.choices = [house02c01d04Doce,house02c02d04Doce,house02c03d04Doce]
    
    house02c01d04Doce.child = [house02d05Doce]
    
    house02c02d04Doce.child = [house02d01c02d04Doce]
    house02d01c02d04Doce.add(child: house02d02c02d04Doce)
    house02d02c02d04Doce.add(child: house02d03c02d04Doce)
    house02d03c02d04Doce.add(child: house02d05Doce)
    
    house02c03d04Doce.child = [house02d05Doce]
    
    house02d05Doce.add(child: house02RootNormal)
    
    house02RootNormal.add(child: house02d02)
    house02d02.choices = [house02c03d02,house02c01d02,house02c02d02]
    
    house02c01d02.child = [house02d02c02d02]
    
    
    house02c02d02.child = [house02d01c02d02]
    house02d01c02d02.add(child: house02d02c02d02)
    house02d02c02d02.add(child: house02d03c02d02)
    house02d03c02d02.add(child: house02d04c02d02)
    house02d03c02d02.typeBallon = .thought
    house02d04c02d02.add(child: house02d03)
    
    house02c03d02.child = [house02d01c03d02]
    house02d01c03d02.add(child: house02d02c03d02)
    house02d02c03d02.add(child: house02d03c03d02)
    house02d03c03d02.add(child: house02d03)
    house02d03c03d02.typeBallon = .thought
    
    house02d03.add(child: house02d04)
    house02d04.add(child: house02d05)
    house02d05.add(child: house02d06)
    
}
