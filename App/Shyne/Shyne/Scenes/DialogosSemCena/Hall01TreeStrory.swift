//
//  Hall01TreeStrory.swift
//  Shyne
//
//  Created by Nickson Kley Gonçalves Da Silva on 13/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation

var hall01PlayerNameNode = "playerNode"
var hall01AnaNameNode = "Ana"

var hall01Root = Node(withText: NSLocalizedString("Você viu o concurso?", comment: ""), withChoices: [], inNodeNamed: hall01AnaNameNode, audioName: "ana_voice01")

var hall01ETRoot = Node(withText: NSLocalizedString("Sim, vi sim", comment: ""), withChoices: [], inNodeNamed: hall01PlayerNameNode, audioName: "felipe_Voice01")
var hall01ETd02 = Node(withText: NSLocalizedString("Legal né?", comment: ""), withChoices: [], inNodeNamed: hall01AnaNameNode, audioName: "ana_voice01")
var hall01ETd03 = Node(withText: NSLocalizedString("É", comment: ""), withChoices: [], inNodeNamed: hall01PlayerNameNode, audioName: "felipe_Voice02")
var hall01ETd04 = Node(withText: NSLocalizedString("Vai, reage de alguma forma", comment: ""), withChoices: [], inNodeNamed: hall01AnaNameNode, audioName: "ana_voice03")
var hall01ETd05 = Node(withText: NSLocalizedString("É a empresa que você mais gosta e você só diz 'é'", comment: ""), withChoices: [], inNodeNamed: hall01AnaNameNode, audioName: "ana_voice01")
var hall01ETd06 = Node(withText: NSLocalizedString("Animo e se inscreva!", comment: ""), withChoices: [], inNodeNamed: hall01AnaNameNode, audioName: "ana_voice02")
var hall01ETd07 = Node(withText: NSLocalizedString("Eu me inscrever?", comment: ""), withChoices: [], inNodeNamed: hall01PlayerNameNode, audioName: "felipe_Voice03")
var hall01ETd08 = Node(withText: NSLocalizedString("Claro, você é a pessoa que mais ama essa empresa, depois de mim é claro", comment: ""), withChoices: [], inNodeNamed: hall01AnaNameNode, audioName: "ana_voice03")
var hall01ETd09 = Node(withText: NSLocalizedString("kkk", comment: ""), withChoices: [], inNodeNamed: hall01PlayerNameNode, audioName: "felipe_Laught03")
var hall01ETd10 = Node(withText: NSLocalizedString("Mas tem que fazer um vídeo e eu não gosto nem de bater foto", comment: ""), withChoices: [], inNodeNamed: hall01PlayerNameNode, audioName: "felipe_Voice02")
var hall01ETd11 = Node(withText: NSLocalizedString("Deixa disso. É para conhecer a Avocado games", comment: ""), withChoices: [], inNodeNamed: hall01AnaNameNode, audioName: "ana_voice01")
var hall01ETd12 = Node(withText: NSLocalizedString("Se você se inscrever eu até te ajudo a fazer o vídeo", comment: ""), withChoices: [], inNodeNamed: hall01AnaNameNode, audioName: "ana_voice02")
var hall01ETd13 = Node(withText: NSLocalizedString("Você não quer ir também", comment: ""), withChoices: [], inNodeNamed: hall01PlayerNameNode, audioName: "felipe_Voice01")
var hall01ETd14 = Node(withText: NSLocalizedString("Claro que quero. Mas prefiro que você vá é seu sonho a muito tempo", comment: ""), withChoices: [], inNodeNamed: hall01AnaNameNode, audioName: "ana_voice03")
var hall01ETd15 = Node(withText: NSLocalizedString("Vai se inscrever!!", comment: ""), withChoices: [], inNodeNamed: hall01AnaNameNode, audioName: "ana_voice01")
var hall01ETd16 = Node(withText: NSLocalizedString("OK", comment: ""), withChoices: [], inNodeNamed: hall01PlayerNameNode, audioName: "felipe_Laught01")

var hall01EFRoot = Node(withText: NSLocalizedString("Que concurso?", comment: ""), withChoices: [], inNodeNamed: hall01PlayerNameNode, audioName: "felipe_Voice01")
var hall01EFd02 = Node(withText: NSLocalizedString("Você não leu seus emails hoje?", comment: ""), withChoices: [], inNodeNamed: hall01AnaNameNode, audioName: "ana_voice01")
var hall01EFd03 = Node(withText: NSLocalizedString("Não", comment: ""), withChoices: [], inNodeNamed: hall01PlayerNameNode, audioName: "felipe_Voice03")
var hall01EFd04 = Node(withText: NSLocalizedString("Você não lia seus emails todo dia de manhã", comment: ""), withChoices: [], inNodeNamed: hall01AnaNameNode, audioName: "ana_voice02")
var hall01EFd05 = Node(withText: NSLocalizedString("As vezes eu esqueço", comment: ""), withChoices: [], inNodeNamed: hall01PlayerNameNode, audioName: "felipe_Voice05")
var hall01EFd06 = Node(withText: NSLocalizedString("As vezes", comment: ""), withChoices: [], inNodeNamed: hall01AnaNameNode, audioName: "ana_voice01")
var hall01EFd07 = Node(withText: NSLocalizedString("Afinal que concurso?", comment: ""), withChoices: [], inNodeNamed: hall01PlayerNameNode, audioName: "felipe_Voice02")
var hall01EFd08 = Node(withText: NSLocalizedString("Pega seu telefone e ler o email", comment: ""), withChoices: [], inNodeNamed: hall01AnaNameNode, audioName: "ana_voice03")
var hall01EFd09 = Node(withText: NSLocalizedString("Eu não tenho email no celular", comment: ""), withChoices: [], inNodeNamed: hall01PlayerNameNode, audioName: "felipe_Voice01")
var hall01EFd10 = Node(withText: NSLocalizedString("Como não", comment: ""), withChoices: [], inNodeNamed: hall01AnaNameNode, audioName: "ana_voice01")
var hall01EFd11 = Node(withText: NSLocalizedString("Não tendo", comment: ""), withChoices: [], inNodeNamed: hall01PlayerNameNode, audioName: "felipe_Voice04")
var hall01EFd12 = Node(withText: NSLocalizedString("Você não pode me falar?", comment: ""), withChoices: [], inNodeNamed: hall01PlayerNameNode, audioName: "felipe_Voice02")
var hall01EFd13 = Node(withText: NSLocalizedString("Não!!", comment: ""), withChoices: [], inNodeNamed: hall01AnaNameNode, audioName: "ana_voice01")
var hall01EFd14 = Node(withText: NSLocalizedString("Quando você chegar em casa você lê. Ok?", comment: ""), withChoices: [], inNodeNamed: hall01AnaNameNode, audioName: "ana_voice03")
var hall01EFd15 = Node(withText: NSLocalizedString("Ok", comment: ""), withChoices: [], inNodeNamed: hall01PlayerNameNode, audioName: "felipe_Voice02")
var hall01EFd16 = Node(withText: NSLocalizedString("Vê se nao esquece.", comment: ""), withChoices: [], inNodeNamed: hall01AnaNameNode, audioName: "ana_voice01")

var hall01SBTRoot = Node(withText: NSLocalizedString("Vou tentar puxar conversa", comment: ""), withChoices: [], inNodeNamed: hall01PlayerNameNode)
var hall01SBTd02 = Node(withText: NSLocalizedString("Já aconteceu de alguém mandar você comprar algo?", comment: ""), withChoices: [], inNodeNamed: hall01PlayerNameNode, audioName: "felipe_Voice01")
var hall01SBTd03 = Node(withText: NSLocalizedString("E você comprar o errado?", comment: ""), withChoices: [], inNodeNamed: hall01PlayerNameNode, audioName: "felipe_Voice03")
var hall01SBTd04 = Node(withText: NSLocalizedString("Não", comment: ""), withChoices: [], inNodeNamed: hall01AnaNameNode, audioName: "ana_Voice01")
var hall01SBTd05 = Node(withText: NSLocalizedString("kkk", comment: ""), withChoices: [], inNodeNamed: hall01AnaNameNode, audioName: "ana_laught03")
var hall01SBTd06 = Node(withText: NSLocalizedString("Não?", comment: ""), withChoices: [], inNodeNamed: hall01PlayerNameNode, audioName: "felipe_Voice01")
var hall01SBTd07 = Node(withText: NSLocalizedString("É comigo tambêm não", comment: ""), withChoices: [], inNodeNamed: hall01PlayerNameNode, audioName: "felipe_Voice03")

func hall01MakeTree(){
    //TODO: Definir o filho de hall01Root
    
    hall01ETRoot.add(child: hall01ETd02)
    hall01ETd02.add(child: hall01ETd03)
    hall01ETd03.add(child: hall01ETd04)
    hall01ETd04.add(child: hall01ETd05)
    hall01ETd05.add(child: hall01ETd06)
    hall01ETd06.add(child: hall01ETd07)
    hall01ETd07.add(child: hall01ETd08)
    hall01ETd08.add(child: hall01ETd09)
    hall01ETd09.add(child: hall01ETd10)
    hall01ETd10.add(child: hall01ETd11)
    hall01ETd11.add(child: hall01ETd12)
    hall01ETd12.add(child: hall01ETd13)
    hall01ETd13.add(child: hall01ETd14)
    hall01ETd14.add(child: hall01ETd15)
    hall01ETd15.add(child: hall01ETd16)
    
    hall01EFRoot.add(child: hall01EFd02)
    hall01EFd02.add(child: hall01EFd03)
    hall01EFd03.add(child: hall01EFd04)
    hall01EFd04.add(child: hall01EFd05)
    hall01EFd05.add(child: hall01EFd06)
    hall01EFd06.add(child: hall01EFd07)
    hall01EFd07.add(child: hall01EFd08)
    hall01EFd08.add(child: hall01EFd09)
    hall01EFd09.add(child: hall01EFd10)
    hall01EFd10.add(child: hall01EFd11)
    hall01EFd11.add(child: hall01EFd12)
    hall01EFd12.add(child: hall01EFd13)
    hall01EFd13.add(child: hall01EFd14)
    hall01EFd14.add(child: hall01EFd15)
    hall01EFd15.add(child: hall01EFd16)
    
    //TODO checar a chave SweetBread
    
    hall01SBTRoot.add(child: hall01SBTd02)
    hall01SBTRoot.typeBallon = .thought
    hall01SBTd02.add(child: hall01SBTd03)
    hall01SBTd03.add(child: hall01SBTd04)
    hall01SBTd04.add(child: hall01SBTd05)
    hall01SBTd05.add(child: hall01SBTd06)
    hall01SBTd06.add(child: hall01SBTd07)
}

