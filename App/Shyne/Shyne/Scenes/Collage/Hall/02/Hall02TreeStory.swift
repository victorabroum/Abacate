//
//  Hall02TreeStory.swift
//  Shyne
//
//  Created by Nickson Kley Gonçalves Da Silva on 14/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation

var hall02PlayerNameNode = "playerNode"
var hall02AnaNameNode = "Ana"

var hall02Root = Node(withText: "", withChoices: [])

var hall02TRoot = Node(withText: NSLocalizedString("Eu vi que você ficou sem equipe", comment: ""), withChoices: [], inNodeNamed: hall02AnaNameNode, audioName: "ana_Voice03")

var hall02Td02 = Node(withText: NSLocalizedString("É", comment: ""), withChoices: [], inNodeNamed: hall02PlayerNameNode, audioName: "felipe_Voice03")
var hall02Td03 = Node(withText: NSLocalizedString("Pô cara,", comment: ""), withChoices: [], inNodeNamed: hall02AnaNameNode, audioName: "ana_Voice01")
var hall02Td04 = Node(withText: NSLocalizedString("Você que fazer comigo?", comment: ""), withChoices: [], inNodeNamed: hall02AnaNameNode, audioName: "ana_Voice02")
var hall02Td05 = Node(withText: NSLocalizedString("...Obrigado", comment: ""), withChoices: [], inNodeNamed: hall02PlayerNameNode, audioName: "felipe_Voice01")

var hall02FRoot = Node(withText: NSLocalizedString("Ei!!", comment: ""), withChoices: [], inNodeNamed: hall02AnaNameNode, audioName: "ana_Voice01")
var hall02Fd02 = Node(withText: NSLocalizedString("Legal você ter me chamado para sua equipe", comment: ""), withChoices: [], inNodeNamed: hall02AnaNameNode, audioName: "ana_Voice03")
var hall02Fd03 = Node(withText: NSLocalizedString("Que isso!", comment: ""), withChoices: [], inNodeNamed: hall02PlayerNameNode, audioName: "felipe_Voice04")
var hall02Fd04 = Node(withText: NSLocalizedString("Você é minha amiga", comment: ""), withChoices: [], inNodeNamed: hall02PlayerNameNode, audioName: "felipe_Voice05")
var hall02Fd05 = Node(withText: NSLocalizedString("É você quem vai organizar o trabalho?", comment: ""), withChoices: [], inNodeNamed: hall02AnaNameNode, audioName: "ana_Voice02")
var hall02Fd06 = Node(withText: NSLocalizedString("Sim, sim, mas queria que você me ajudasse", comment: ""), withChoices: [], inNodeNamed: hall02PlayerNameNode, audioName: "felipe_Voice01")
var hall02Fd07 = Node(withText: NSLocalizedString("...", comment: ""), withChoices: [], inNodeNamed: hall02AnaNameNode, audioName: "ana_Voice01")
var hall02Fd08 = Node(withText: NSLocalizedString("Ok", comment: ""), withChoices: [], inNodeNamed: hall02AnaNameNode, audioName: "ana_Voice03")

func hall02MakeTree(){
    if(PlayerModel.getInstance().keys.contains("Iniciativa")){
        hall02Root = hall02FRoot
    }
    else{
        hall02Root = hall02TRoot
    }
}
