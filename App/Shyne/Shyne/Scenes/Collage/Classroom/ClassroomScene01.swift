//
//  ClassroomScene01.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 21/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class ClassroomScene01: SKScene {

    
    var playerNode: PlayerNode?
    var dialogBox01: Dialogavel?
    
    var entities = [GKEntity]()
    
    override func sceneDidLoad() {
        self.playerNode = childNode(withName: "playerNode") as? PlayerNode
        
        // Dizendo que a scene comanda o delegate
        // Criando a box do diálogo
        self.dialogBox01 = Dialogavel(cena: self)
        //Preparando a tree story dessa scene
        classRoomRootmakeTree()
        // Indicando a raiz da story
        self.dialogBox01!.indexNode = classRoomRoot
        carregarFalas()
    }
    
    func carregarFalas(){
        
        //func b1
        let cenaProxima1: GKScene = GKScene(fileNamed: "HouseScene03")!
        
        if let nextScene1 = cenaProxima1.rootNode as? HouseScene03{
            nextScene1.entities = cenaProxima1.entities
            var t1 : Transicao
            t1 = Transicao(cenaAtual: self, cenaProxima: nextScene1)
            classRoomRootc1.function = {()->Void in t1.troca()}
        }
        //func b2
        
        let cenaProxima2: GKScene = GKScene(fileNamed: "HouseScene02")!
        
        if let nextScene2 = cenaProxima2.rootNode as? HouseScene02{
            nextScene2.entities = cenaProxima2.entities
            var t2 : Transicao
            t2 = Transicao(cenaAtual: self, cenaProxima: nextScene2)
            classRoomRootc2.function = {()->Void in t2.troca()}
        }
        
        //func b3
        let cenaProxima3: GKScene = GKScene(fileNamed: "HouseScene01")!
        
        if let nextScene3 = cenaProxima3.rootNode as? HouseScene01{
            nextScene3.entities = cenaProxima3.entities
            var t3 : Transicao
            t3 = Transicao(cenaAtual: self, cenaProxima: nextScene3)
            classRoomRootc3.function = {()->Void in t3.troca()}
        }
        
        self.dialogBox01!.caixa = caixaDeDialogo(personagem: self.childNode(withName: "professora")!, texto: (lista["professora"]?.mensagem)!, dialogavel: self.dialogBox01!)
        lista["professora"]?.funcaoEntrada = {(n:caixa)->Void in n.entrar()}
        lista["professora"]?.funcaoSaida = {(n:caixa)->Void in n.sair()}
        lista["professora"]?.funcaoEntrada!(self.dialogBox01!.caixa!)
    }
    override func update(_ currentTime: TimeInterval) {
        
    }
}
