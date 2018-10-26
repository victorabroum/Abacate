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
        self.dialogBox01!.caixa = caixaDeDialogo(personagem: self.childNode(withName: "professora")!, texto: (lista["professora"]?.mensagem)!, dialogavel: self.dialogBox01!)
        lista["professora"]?.funcaoEntrada = {(n:caixa)->Void in n.entrar()}
        lista["professora"]?.funcaoSaida = {(n:caixa)->Void in n.sair()}
        lista["professora"]?.funcaoEntrada!(self.dialogBox01!.caixa!)
    }
    override func update(_ currentTime: TimeInterval) {
        if(self.dialogBox01?.indexNode?.childrens == nil){
            print("Acabou")
        }
    }
}
