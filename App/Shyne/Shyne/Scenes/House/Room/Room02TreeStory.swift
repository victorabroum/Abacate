//
//  Room02TreeStory.swift
//  Shyne
//
//  Created by Nickson Kley Gonçalves Da Silva on 30/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation

var room02Root = Node(withText: NSLocalizedString("Eu tinha que ensaiar\npara o trabalho..", comment: ""), withChoices: [])

var room02c01 = Answer(withText: NSLocalizedString("Ligar o PC para estudar\npara a apresentação", comment: ""), withAmount: Feel(happy: 3, normal: 2, shy: 0))
var room02c02 = Answer(withText: NSLocalizedString("Ir dormir", comment: ""), withAmount: Feel(happy: 0, normal: 0, shy: 4))
var room02c03 = Answer(withText: NSLocalizedString("Ensaiar para a apresenção", comment: ""), withAmount: Feel(happy: 3, normal: 2, shy: 0))

func room02MakeTree(){
    room02Root.choices = []
    if(PlayerModel.getInstance().keys.contains("Desligar")){
        room02Root.choices = [room02c01,room02c02]
    }
    else{
        room02Root.choices = [room02c02,room02c03]
    }
}
