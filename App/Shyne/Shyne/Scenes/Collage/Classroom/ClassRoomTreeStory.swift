//
//  ClassRoomTreeStory.swift
//  Shyne
//
//  Created by Ruy de Ascencão Neto on 22/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation
import GameplayKit

var classroom01PlayerNameNode = "playerNodeTalk"
var classroom01ProfessoraNameNode = "professora"
var classroom01AnaNameNode = "annaTalk"


//var classRoomRoot: Node = Node(withText: NSLocalizedString("So with this, we \n finish another subject.", comment: ""), withChoices: [],inNodeNamed:"professora")
//
//var classRoom01D1: Node = Node(withText: NSLocalizedString("Form groups\nof 4 people.", comment: ""), withChoices: [],inNodeNamed:"professora")
//
//var classRoom01D2: Node = Node(withText: NSLocalizedString("We'll have a presentation \n 5 days from now.", comment: ""), withChoices: [],inNodeNamed:"professora")
//
//var classRoomRootc1: Answer = Answer(withText: NSLocalizedString("I'll make my\n own team.", comment: ""),withAmount: Feel(happy: 1, normal: 0.3, shy: 0), withChild: [class01Player01])
//
//var classRoomRootc2: Answer = Answer(withText: NSLocalizedString("I'll go to \nRuy's team.", comment: ""), withAmount: Feel(happy: 0, normal: 0.5, shy: 0.1), withChild: [class01Player01])
//
//var classRoomRootc3: Answer = Answer(withText: NSLocalizedString("I'll wait for\n someone to pick me.", comment: ""), withAmount: Feel(happy: 0, normal: 0.2, shy: 1), withChild: [class01Player03])
//
//
//var class01Player01 = Node(withText: NSLocalizedString("Alright, tomorrow \ni'll settle this!", comment: ""), withChoices: [], inNodeNamed: "playerNode")
//
//var class01Player02 = Node(withText: NSLocalizedString("I getter get going now.", comment: ""), withChoices: [], inNodeNamed: "playerNode")
//
//var class01Player03 = Node(withText: NSLocalizedString("Let's face it.. \nno one's gonna pick me.", comment: ""), withChoices: [], inNodeNamed: "playerNode")
//
//var class01Player04 = Node(withText: NSLocalizedString("Alright, I'll\n do it by myself.", comment: ""), withChoices: [], inNodeNamed: "playerNode")

var classRoom01Root = Node(withText: NSLocalizedString("Então esse é o ultimo\nassunto do período", comment: "Período da faculdade"), withChoices: [], inNodeNamed: classroom01ProfessoraNameNode, audioName: "teacher_Voice01")
var classRoom01d02 = Node(withText: NSLocalizedString("A nota final será um\ntrabalho em dupla", comment: ""), withChoices: [], inNodeNamed: classroom01ProfessoraNameNode, audioName: "teacher_Voice02")
var classRoom01d03 = Node(withText: NSLocalizedString("Que bom não vou\nter que apresentar", comment: ""), withChoices: [], inNodeNamed: classroom01PlayerNameNode)
var classRoom01d04 = Node(withText: NSLocalizedString("Todos os membros\ntem que apresentar", comment: ""), withChoices: [], inNodeNamed: classroom01ProfessoraNameNode, audioName: "teacher_Voice03")
var classRoom01d05 = Node(withText: NSLocalizedString("E a apresentação\nserá amanha", comment: ""), withChoices: [], inNodeNamed: classroom01ProfessoraNameNode, audioName: "teacher_Voice03")
var classRoom01d06 = Node(withText: NSLocalizedString("Sério", comment: ""), withChoices: [], inNodeNamed: classroom01PlayerNameNode)

var classRoom01c01d06 = Answer(withText: "Chamar a Ana para\nfazer equipe", withAmount: Feel(happy: 5, normal: 0, shy: 0))// indo a ana

var classRoom01d01c01d06 = Node(withText: NSLocalizedString("Então...", comment: ""), withChoices: [], inNodeNamed: classroom01PlayerNameNode)
var classRoom01d02c01d06 = Node(withText: NSLocalizedString("Ééééé", comment: ""), withChoices: [], inNodeNamed: classroom01PlayerNameNode)
var classRoom01d03c01d06 = Node(withText: NSLocalizedString("Que foi??", comment: ""), withChoices: [], inNodeNamed: classroom01AnaNameNode)
var classRoom01d04c01d06 = Node(withText: NSLocalizedString("Que fazer o trabalho comigo?", comment: ""), withChoices: [], inNodeNamed: classroom01PlayerNameNode)
var classRoom01d05c01d06 = Node(withText: NSLocalizedString("...", comment: ""), withChoices: [], inNodeNamed: classroom01AnaNameNode)
var classRoom01d06c01d06 = Node(withText: NSLocalizedString("Claro", comment: ""), withChoices: [], inNodeNamed: classroom01AnaNameNode)
var classRoom01d07c01d06 = Node(withText: NSLocalizedString("kkkk", comment: ""), withChoices: [], inNodeNamed: classroom01AnaNameNode, audioName: "ana_Laught01")//key tomou a iniciativa

var classRoom01c02d06 = Answer(withText: "Esperar me\nescolherem", withAmount: Feel(happy: 0, normal: 2, shy: 0))//chave naoTomouIniciativa

var classRoom01d01c02d06 = Node(withText: NSLocalizedString("Espero que a Ana me escolha", comment: ""), withChoices: [], inNodeNamed: classroom01PlayerNameNode)//Sala vazia
var classRoom01d02c02d06 = Node(withText: NSLocalizedString("E Ninguém me escolheu", comment: ""), withChoices: [], inNodeNamed: classroom01PlayerNameNode)

var classRoom01c03d06 = Answer(withText: "Fazer sozinho", withAmount: Feel(happy: 0, normal: 0, shy: 5))//chave naoTomouIniciativa


func classRoomRootmakeTree(){
//    classRoomRoot.childrens = [classRoom01D2]
//
//    classRoom01D2.childrens = [classRoom01D1]
//
//    classRoom01D1.choices.append(classRoomRootc1)
//    classRoom01D1.choices.append(classRoomRootc2)
//    classRoom01D1.choices.append(classRoomRootc3)
//
//    class01Player01.childrens.append(class01Player02)
//    class01Player03.childrens.append(class01Player04)
//    class01Player04.childrens.append(class01Player02)
    
    classRoom01Root.add(child: classRoom01d02)
    classRoom01d02.add(child: classRoom01d03)
    classRoom01d03.add(child: classRoom01d04)
    classRoom01d03.typeBallon = .thought
    classRoom01d04.add(child: classRoom01d05)
    classRoom01d05.add(child: classRoom01d06)
    
    classRoom01d06.choices = [classRoom01c03d06,classRoom01c02d06,classRoom01c01d06]
    classRoom01d06.typeBallon = .thought
    
    classRoom01c01d06.child = [classRoom01d01c01d06]
    classRoom01d01c01d06.add(child: classRoom01d02c01d06)
    classRoom01d02c01d06.add(child: classRoom01d03c01d06)
    classRoom01d03c01d06.add(child: classRoom01d04c01d06)
    classRoom01d04c01d06.add(child: classRoom01d05c01d06)
    classRoom01d05c01d06.add(child: classRoom01d06c01d06)
    classRoom01d06c01d06.add(child: classRoom01d07c01d06)
    
    classRoom01c02d06.child = [classRoom01d01c02d06]
    classRoom01d01c02d06.add(child: classRoom01d02c02d06)
    classRoom01d01c02d06.typeBallon = .thought
    classRoom01d02c02d06.typeBallon = .thought
    
    
    
}
