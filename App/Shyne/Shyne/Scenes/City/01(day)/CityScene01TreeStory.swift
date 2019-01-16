//
//  CityScene01TreeStory.swift
//  Shyne
//
//  Created by Nickson Kley Gonçalves Da Silva on 10/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation

var city01PlayerNameNode = "playerNode"
var city01VioleiroNameNode = "xandyTalk"
var city01DoorTalkNameNode = "caraChato"
var city01GrandMotherNameNode = "velhaTalk"

var violeiro01Root = Node(withText: NSLocalizedString("...", comment: ""), withChoices: [], inNodeNamed: city01PlayerNameNode, audioName: "felipe_Sigh03")

var violeiro01d02 = Node(withText: NSLocalizedString("Tudo bem?", comment: ""), withChoices: [], inNodeNamed: city01VioleiroNameNode, audioName: "violeiro_Voice01")

var violeiro01d03 = Node(withText: NSLocalizedString("...", comment: "Movimento de afirmaçao com a cabeça"), withChoices: [], inNodeNamed: city01PlayerNameNode, audioName: "felipe_sigh03")

var viloeiro01d04 = Node(withText: NSLocalizedString("Você gostou da música?", comment: ""), withChoices: [], inNodeNamed: city01VioleiroNameNode, audioName: "violeiro_Voice02")

var violeiro01d05 = Node(withText: NSLocalizedString("...", comment: "Movimento de afirmaçao com a cabeça"), withChoices: [], inNodeNamed: city01PlayerNameNode, audioName: "felipe_sigh03")

var violeiro01d06 = Node(withText: NSLocalizedString("Sabe falar?", comment: ""), withChoices: [], inNodeNamed: city01VioleiroNameNode, audioName: "violeiro_Voice03")

    var violeiro01c01d06 = Answer(withText: NSLocalizedString("Música legal", comment: ""), withAmount: Feel(happy: 0, normal: 1, shy: 0), audioName: "felipe_Voice04")
        var violeiro01d01c01d06 = Node(withText: NSLocalizedString("Muito obrigado. Fui eu quem compus", comment: "Compor de música"), withChoices: [], inNodeNamed: city01VioleiroNameNode, audioName: "violeiro_Voice02")
        var violeiro01d02c01d06 = Node(withText: NSLocalizedString("Qual o nome da música", comment: ""), withChoices: [], inNodeNamed: city01PlayerNameNode, audioName: "felipe_Voice02")
        var violeiro01d03c01d06 = Node(withText: NSLocalizedString("O Brilho Do Sol", comment: ""), withChoices: [], inNodeNamed: city01VioleiroNameNode, audioName: "violeiro_Voice01")

    var violeiro01c02d06 = Answer(withText: "Você toca bem", withAmount: Feel(happy: 0, normal: 1, shy: 0), audioName: "felipe_Voice04")

var violeiro01d07 = Node(withText: NSLocalizedString("Se você quiser aprender alguma coisa sobre música.", comment: ""), withChoices: [], inNodeNamed: city01VioleiroNameNode, audioName: "violeiro_Voice03")

var violeiro01d08 = Node(withText: NSLocalizedString("Vou voltar para tocar aqui alguns dias.", comment: ""), withChoices: [], inNodeNamed: city01VioleiroNameNode, audioName: "violeiro_Voice02")

var violeiro01d09 = Node(withText: NSLocalizedString("Poxa, valeu. Já tenho que ir", comment: ""), withChoices: [], inNodeNamed: city01PlayerNameNode, audioName: "felipe_Voice05")

var violeiro01d10 = Node(withText: NSLocalizedString("OK", comment: ""), withChoices: [], inNodeNamed: city01VioleiroNameNode, audioName: "violeiro_Voice01")

/////////////////////////////////////////////////

var porta01 = Node(withText: NSLocalizedString("NÃO QUERO BISCOITOS!!!", comment: ""), withChoices: [], inNodeNamed: city01DoorTalkNameNode, audioName: "angry_Voice01")
var porta02 = Node(withText: NSLocalizedString("ESTOU OCUPADO!!!", comment: ""), withChoices: [], inNodeNamed: city01DoorTalkNameNode, audioName: "angry_Voice02")
var porta03 = Node(withText: NSLocalizedString("YO NO HABLO SU IDIOMA!!!", comment: "deixar em espanhol"), withChoices: [], inNodeNamed: city01DoorTalkNameNode, audioName: "angry_Voice03")

var porta01Root : Node = Node(withText: "", withChoices: [])

//////////////////////////////////////////////////////

var old01Root = Node(withText: NSLocalizedString("Bom dia, José", comment: ""), withChoices: [], inNodeNamed: city01GrandMotherNameNode, audioName: "grandMother_Voice01")
var old01d02 = Node(withText: NSLocalizedString("Eu sou o Felipe, dona Maria. Bom dia", comment: ""), withChoices: [], inNodeNamed: city01PlayerNameNode, audioName: "felipe_Voice01")
var old01d03 = Node(withText: NSLocalizedString("Felipe??", comment: ""), withChoices: [], inNodeNamed: city01GrandMotherNameNode, audioName: "grandMother_Voice02")
var old01d04 = Node(withText: NSLocalizedString("...", comment: ""), withChoices: [], inNodeNamed: city01GrandMotherNameNode, audioName: "grandMother_Voice03")
var old01d05 = Node(withText: NSLocalizedString("Meu Deus, meu filho você cresceu muito!!", comment: ""), withChoices: [], inNodeNamed: city01GrandMotherNameNode, audioName: "grandMother_Voice02")
var old01d06 = Node(withText: NSLocalizedString("Eu lembro de carreger você no colo", comment: ""), withChoices: [], inNodeNamed: city01GrandMotherNameNode, audioName: "grandMother_Voice02")
var old01d07 = Node(withText: NSLocalizedString("...", comment: ""), withChoices: [], inNodeNamed: city01PlayerNameNode, audioName: "felipe_Voice01")
var old01d08 = Node(withText: NSLocalizedString("...", comment: ""), withChoices: [], inNodeNamed: city01GrandMotherNameNode, audioName: "grandMother_Voice03")
var old01d09 = Node(withText: NSLocalizedString("Você ainda não fala muito, né?", comment: ""), withChoices: [], inNodeNamed: city01GrandMotherNameNode, audioName: "grandMother_Voice01")
var old01d10 = Node(withText: NSLocalizedString("Como está seu gatinho", comment: ""), withChoices: [], inNodeNamed: city01PlayerNameNode, audioName: "felipe_Voice02")
var old01d11 = Node(withText: NSLocalizedString("Tá bem, meu filho", comment:""), withChoices: [], inNodeNamed: city01GrandMotherNameNode, audioName: "grandMother_Voice01")
var old01d12 = Node(withText: NSLocalizedString("...", comment: ""), withChoices: [], inNodeNamed: city01PlayerNameNode, audioName: "felipe_Voice01")
var old01d13 = Node(withText: NSLocalizedString("Estou vendo que você está ocupado", comment:""), withChoices: [], inNodeNamed: city01GrandMotherNameNode, audioName: "grandMother_Voice01")
var old01d14 = Node(withText: NSLocalizedString("Tchau!!", comment:""), withChoices: [], inNodeNamed: city01GrandMotherNameNode, audioName: "grandMother_Voice01")
var old01d15 = Node(withText: NSLocalizedString("Tchau, dona Maria", comment:""), withChoices: [], inNodeNamed: city01PlayerNameNode, audioName: "felipe_Voice01")




func city01MakeTree(){
    porta01Root = porta01
    porta01.action = {
        porta01Root = porta02
        
    }
    porta02.action = {
        porta01Root = porta03
        
    }
    porta03.action = {
        porta01Root = porta01
        
    }
    
    violeiro01Root.add(child: violeiro01d02)
    violeiro01d02.add(child: violeiro01d03)
    violeiro01d03.add(child: viloeiro01d04)
    viloeiro01d04.add(child: violeiro01d05)
    violeiro01d05.add(child: violeiro01d06)
    violeiro01d06.choices = [violeiro01c01d06,violeiro01c02d06]
    
    violeiro01c01d06.child = [violeiro01d01c01d06]
    violeiro01d01c01d06.add(child: violeiro01d02c01d06)
    violeiro01d02c01d06.add(child: violeiro01d03c01d06)
    violeiro01d03c01d06.add(child: violeiro01d07)
    
    violeiro01c02d06.child = [violeiro01d07]
    
    violeiro01d07.add(child: violeiro01d08)
    violeiro01d08.add(child: violeiro01d09)
    violeiro01d09.add(child: violeiro01d10)
    
    old01Root.add(child: old01d02)
    old01d02.add(child: old01d03)
    old01d03.add(child: old01d04)
    old01d04.add(child: old01d05)
    old01d05.add(child: old01d06)
    old01d06.add(child: old01d07)
    old01d07.add(child: old01d08)
    old01d08.add(child: old01d09)
    old01d09.add(child: old01d10)
    old01d10.add(child: old01d11)
    old01d11.add(child: old01d12)
    old01d12.add(child: old01d13)
    old01d13.add(child: old01d14)
    old01d14.add(child: old01d15)
}
