//
//  Hall02TreeStory.swift
//  Shyne
//
//  Created by Nickson Kley Gonçalves Da Silva on 14/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation

var hall02PlayerNameNode = "playerNode"
var hall02AnaNameNode = "anaNodeTalk"

var hall02Root = Node(withText: "", withChoices: [])

var hall02TRoot = Node(withText: NSLocalizedString("Eu vi que você\nficou sem equipe", comment: ""), withChoices: [], inNodeNamed: hall02AnaNameNode, audioName: "ana_Voice03")

var hall02Td02 = Node(withText: NSLocalizedString("É", comment: ""), withChoices: [], inNodeNamed: hall02PlayerNameNode, audioName: "felipe_Voice03")
var hall02Td03 = Node(withText: NSLocalizedString("Poh cara", comment: ""), withChoices: [], inNodeNamed: hall02AnaNameNode, audioName: "ana_Voice01")
var hall02Td04 = Node(withText: NSLocalizedString("Você quer fazer comigo?", comment: ""), withChoices: [], inNodeNamed: hall02AnaNameNode, audioName: "ana_Voice02")
var hall02Td05 = Node(withText: NSLocalizedString("...Obrigado", comment: ""), withChoices: [], inNodeNamed: hall02PlayerNameNode, audioName: "felipe_Voice01")
var hall02Td06 = Node(withText: NSLocalizedString("Beleza, mais tarde nos falamos", comment: ""), withChoices: [], inNodeNamed: hall02AnaNameNode, audioName: "felipe_Voice01")

var hall02FRoot = Node(withText: NSLocalizedString("Ei!!", comment: ""), withChoices: [], inNodeNamed: hall02AnaNameNode, audioName: "ana_Voice01")
var hall02Fd02 = Node(withText: NSLocalizedString("Legal você ter me\nchamado para sua equipe", comment: ""), withChoices: [], inNodeNamed: hall02AnaNameNode, audioName: "ana_Voice03")
var hall02Fd03 = Node(withText: NSLocalizedString("Que isso", comment: ""), withChoices: [], inNodeNamed: hall02PlayerNameNode, audioName: "felipe_Voice04")
var hall02Fd04 = Node(withText: NSLocalizedString("Você é minha amiga", comment: ""), withChoices: [], inNodeNamed: hall02PlayerNameNode, audioName: "felipe_Voice05")
var hall02Fd05 = Node(withText: NSLocalizedString("Você quem vai\norganizar o trabalho?", comment: ""), withChoices: [], inNodeNamed: hall02AnaNameNode, audioName: "ana_Voice02")
var hall02Fd06 = Node(withText: NSLocalizedString("Sim, Sim, Mas queria\nque você me ajuda-se", comment: ""), withChoices: [], inNodeNamed: hall02PlayerNameNode, audioName: "felipe_Voice01")
var hall02Fd07 = Node(withText: NSLocalizedString("...", comment: ""), withChoices: [], inNodeNamed: hall02AnaNameNode, audioName: "ana_Voice01")
var hall02Fd08 = Node(withText: NSLocalizedString("Ok", comment: ""), withChoices: [], inNodeNamed: hall02AnaNameNode, audioName: "ana_Voice03")
var hall02Fd09 = Node(withText: NSLocalizedString("Nos vemos amanhã", comment: ""), withChoices: [], inNodeNamed: hall02AnaNameNode, audioName: "ana_Voice03")

func hall02MakeTree(){
    
    if(PlayerModel.getInstance().keys.contains("Iniciativa")){
        hall02Root = hall02FRoot
    }
    else{
        hall02Root = hall02TRoot
    }
    
    // True
    hall02TRoot.add(child: hall02Td02)
    hall02Td02.add(child: hall02Td03)
    hall02Td03.add(child: hall02Td04)
    hall02Td04.add(child: hall02Td05)
    hall02Td05.add(child: hall02Td06)
    
    // False
    hall02FRoot.add(child: hall02Fd02)
    hall02Fd02.add(child: hall02Fd03)
    hall02Fd03.add(child: hall02Fd04)
    hall02Fd04.add(child: hall02Fd05)
    hall02Fd05.add(child: hall02Fd06)
    hall02Fd06.add(child: hall02Fd07)
    hall02Fd07.add(child: hall02Fd08)
    hall02Fd08.add(child: hall02Fd09)
    
}
