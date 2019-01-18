//
//  Room02TreeStory.swift
//  Shyne
//
//  Created by Nickson Kley Gonçalves Da Silva on 30/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation

var pcNodeToTalk = "pcTalk"

var room02Root = Node(withText: NSLocalizedString("Eu tinha que ensaiar\npara o trabalho..", comment: ""), withChoices: [])

var room02c01 = Answer(withText: NSLocalizedString("Ligar o PC para estudar\npara a apresentação", comment: ""), withAmount: Feel(happy: 3, normal: 2, shy: 0))
var room02c02 = Answer(withText: NSLocalizedString("Ir dormir", comment: ""), withAmount: Feel(happy: 0, normal: 0, shy: 4))
var room02c03 = Answer(withText: NSLocalizedString("Ensaiar para a apresenção", comment: ""), withAmount: Feel(happy: 3, normal: 2, shy: 0))

var room02c01PC = Answer(withText: NSLocalizedString("Ligar PC", comment: ""), withAmount: Feel(happy: 1, normal: 0, shy: 0))
var room02c02PC = Answer(withText: NSLocalizedString("Apenas ignorar", comment: ""), withAmount: Feel(happy: 0, normal: 0, shy: 0))

var room02d01PC = Node(withText: NSLocalizedString("Vou ler o email\nque a Ana pediu.", comment: ""), withChoices: [])

var room02dOnPC01 = Node(withText: NSLocalizedString(" Então era por isso\nque a Ana estava\ntão animada.", comment: ""), withChoices: [], inNodeNamed: pcNodeToTalk)

var room02dOnPC02 = Node(withText: NSLocalizedString(" A chance de\npoder visitar a\nAvocad Games", comment: ""), withChoices: [], inNodeNamed: pcNodeToTalk)
var room02dOnPC03 = Node(withText: NSLocalizedString(" é algo que\nsempre quis.", comment: ""), withChoices: [], inNodeNamed: pcNodeToTalk)
var room02dOnPC04 = Node(withText: NSLocalizedString(" Pena que não tenho\nchances de ganhar.", comment: ""), withChoices: [], inNodeNamed: pcNodeToTalk)

func room02MakeTree(){
    room02Root.choices = []
    if(PlayerModel.getInstance().keys.contains("Desligar")){
        room02Root.choices = [room02c01,room02c02]
    }
    else{
        room02Root.choices = [room02c02,room02c03]
    }
    
    room02c01PC.child = [room02d01PC]
    
    room02dOnPC01.add(child: room02dOnPC02)
    room02dOnPC02.add(child: room02dOnPC03)
    room02dOnPC03.add(child: room02dOnPC04)
    
    room02dOnPC01.typeBallon = .thought
    room02dOnPC02.typeBallon = .thought
    room02dOnPC03.typeBallon = .thought
    room02dOnPC04.typeBallon = .thought
    
    
}
