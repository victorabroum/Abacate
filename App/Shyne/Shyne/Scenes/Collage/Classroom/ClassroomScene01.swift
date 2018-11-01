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
    
    // To control BG Audios
    var bgAudios: SKNode?
    
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
        let cenaProxima1: GKScene = GKScene(fileNamed: "CityScene02")!
        
        if let nextScene1 = cenaProxima1.rootNode as? CityScene02{
            nextScene1.entities = cenaProxima1.entities
            var t1 : Transicao
            t1 = Transicao(cenaAtual: self, cenaProxima: nextScene1)
            
            class01Player02.action = {
                t1.troca()
            }
        }
        
        
        self.dialogBox01!.caixa = caixaDeDialogo(personagem: self.childNode(withName: "professora")!, texto: (lista["professora"]?.mensagem)!, dialogavel: self.dialogBox01!)
        lista["professora"]?.funcaoEntrada = {(n:caixa)->Void in n.entrar()}
        lista["professora"]?.funcaoSaida = {(n:caixa)->Void in n.sair()}
        lista["professora"]?.funcaoEntrada!(self.dialogBox01!.caixa!)
    }
    
    
    override func didMove(to view: SKView) {
        // Prepare BG Music
        if let bga = self.childNode(withName: "bgAudios") {
            print("BG AUDIOS")
            self.bgAudios = bga
            MusicHelper.startSounds(withAudios: bgAudios!.children, withVolume: 0.8)
        }
    }
    
    override func willMove(from view: SKView) {
        if self.bgAudios != nil{
            MusicHelper.stopSounds(withAudios: self.bgAudios!.children)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
