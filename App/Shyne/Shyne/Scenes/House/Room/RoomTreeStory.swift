//
//  RoomTreeStory.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 18/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation

// D = Diálogo, Cena do quarto
// D1
//var rootNode: Node = Node(withText: "It looks like it's \ngonna be cold today..", withChoices: [])
//
//// D2
//var secondTalk: Node = Node(withText: "Wish I didn't have to\ngo to school..", withChoices: [])
//
////D3
//var terceiraTalk = Node(withText: "Well... I'm hungry", withChoices: [])
//
////D4
//var quartaTalk = Node(withText: "I better come \ndownstairs and eat..", withChoices: [])
///////////////////

var room01PlayerNameNode = "playerNode"
var room01DoorNameNode = "portaTalk"

var room01Root = Node(withText: NSLocalizedString("...", comment: "sigh"), withChoices: [], inNodeNamed: room01PlayerNameNode, audioName: "felipe_Sigh01")


var room01d01 = Node(withText: NSLocalizedString("Por que hoje\nnão é Domingo?!", comment: ""), withChoices: [], inNodeNamed: room01PlayerNameNode, audioName: "")
var room01d02 = Node(withText: NSLocalizedString("Não quero\nir para aula", comment: ""), withChoices: [], inNodeNamed: room01PlayerNameNode, audioName: "felipe_Voice01")
var room01d03 = Node(withText: NSLocalizedString("Ei Felipe,\nAcorda", comment: ""), withChoices: [], inNodeNamed: room01DoorNameNode, audioName: "")

var room01c01d03 = Answer(withText: NSLocalizedString("Não responder nada", comment: ""), withAmount: Feel(happy: 0, normal: 0, shy: 1))
var room01c02d03 = Answer(withText: NSLocalizedString("Já estou acordado!", comment: "Grito"), withAmount: Feel(happy: 1, normal: 1, shy: 0), audioName: "felipe_Voice02")
var room01c03d03 = Answer(withText: NSLocalizedString("Ok...", comment: "falou baixinho"), withAmount: Feel(happy: 0, normal: 1, shy: 1), audioName: "felipe_Voice03")

var room01d04 = Node(withText: NSLocalizedString("Tô é com fome", comment: ""), withChoices: [], inNodeNamed: room01PlayerNameNode, audioName: "")

var room01PC = Node(withText: NSLocalizedString("Não dá tempo de mexer agora", comment: "mexer no computador"), withChoices: [], inNodeNamed: room01PlayerNameNode, audioName: "felipe_Voice01")

var room01c01PC = Answer(withText: NSLocalizedString("Desligar pc", comment: "pc personal Computer"), withAmount: Feel(happy: 0, normal: 0, shy: 0))//concede Chave pc desligado apaga a tela do pc

var room01d01c01PC = Node(withText: NSLocalizedString("Não tem necessidade dele ficar ligado", comment: ""), withChoices: [], inNodeNamed: room01PlayerNameNode, audioName: "felipe_Voice01")

var room01c02PC = Answer(withText: NSLocalizedString("Ler emails", comment: ""), withAmount: Feel(happy: 0, normal: 0, shy: 0))//concede Chave leu email e chama a cena de ler

var room01d01c02PC = Node(withText: NSLocalizedString("Será que a Ana\nrecebeu esse\nemail também??", comment: ""), withChoices: [], inNodeNamed: room01PlayerNameNode, audioName: "felipe_Sigh02")

var room01c03PC = Answer(withText: NSLocalizedString("Apenas ignorar", comment: ""), withAmount: Feel(happy: 0, normal: 0, shy: 0))






// Construindo o fluxo
func makeTreeOfRoom() -> (){
    
//    rootNode.add(child: secondTalk)
//    secondTalk.add(child: terceiraTalk)
//    terceiraTalk.add(child: quartaTalk)
    
    room01Root.add(child: room01d01)
    room01d01.add(child: room01d02)
    room01d01.typeBallon = .thought
    room01d02.add(child: room01d03)
    room01d02.typeBallon = .thought
    room01d03.choices = [room01c01d03, room01c02d03, room01c03d03]
    room01c01d03.child = [room01d04]
    room01c02d03.child = [room01d04]
    room01c03d03.child = [room01d04]
    room01d04.typeBallon = .thought
    
    room01PC.choices = [room01c01PC, room01c02PC, room01c03PC]
    room01c01PC.child = [room01d01c01PC]
    
    room01c02PC.child = [room01d01c02PC]
    
    room01d01c02PC.typeBallon = .thought
    
}
