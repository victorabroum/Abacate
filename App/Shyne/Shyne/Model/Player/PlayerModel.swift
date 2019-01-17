//
//  PlayerModel.swift
//  Shyne
//
//  Created by Ruy de Ascencão Neto on 08/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation

class PlayerModel{
    
    var achviement:Set<String>
    var keys:Set<String>
    var status:PlayerStatus
    var sceneInformation:SceneInformation

    private static var player:PlayerModel?
    
    
    private init(){
        achviement = Set<String>(PlayerDAO.getAchviements())
        keys = Set<String>(PlayerDAO.getKeys())
        
        if(PlayerDAO.getStatus().count==0){
            status = PlayerStatus(bom: 0.0, medio: 0.0, ruim: 0.0)
        }
        else{
            status = PlayerDAO.getStatus()[0]
        }
        
        if(PlayerDAO.getScene().count==0){
            sceneInformation = SceneInformation(previousScenario: "", actualScenario: "")
        }
        else{
            sceneInformation = PlayerDAO.getScene()[0]
        }
    }
    
    static func restartGame(){
        getInstance().achviement = Set<String>(PlayerDAO.getAchviements())
        getInstance().keys = Set<String>(PlayerDAO.getKeys())
        
        if(PlayerDAO.getStatus().count==0){
            getInstance().status = PlayerStatus(bom: 0.0, medio: 0.0, ruim: 0.0)
        }
        else{
            getInstance().status = PlayerDAO.getStatus()[0]
        }
        
        if(PlayerDAO.getScene().count==0){
            getInstance().sceneInformation = SceneInformation(previousScenario: "", actualScenario: "")
        }
        else{
            getInstance().sceneInformation = PlayerDAO.getScene()[0]
        }
    }
    //MARK:GETS
    static func getInstance() -> PlayerModel{
        if(player == nil){
            player = PlayerModel()
        }
        return player!
    }
    
    static func getStatus() -> PlayerStatus{
        return getInstance().status
    }
    
    static func getKeys()->Set<String>{
        return getInstance().keys
    }
    
    static func getScene()->SceneInformation{
        return getInstance().sceneInformation
    }
    
    //Functions auxiliar
    static func incrementStatusBom(_ increment:Float){
        getInstance().status.bom+=increment
    }
    static func incrementStatusMedio(_ increment:Float){
        getInstance().status.medio+=increment
    }
    static func incrementStatusRuim(_ increment:Float){
        getInstance().status.ruim+=increment
    }
    static func changeScene(scene:SceneInformation){
        getInstance().sceneInformation = scene
    }
    
    //MARK: ADD Functions
    static func addAchviement(ach:String){
        getInstance().achviement.insert(ach)
    }
    static func addKeys(k:String){
        getInstance().keys.insert(k)
    }
    static func removeKey(k:String){
        getInstance().keys.remove(k)
    }
    static func savePlayer(){
        print("AUTO SAVE - \(self.getInstance().keys)")
        PlayerDAO.deleteEverything()
        
        for a in getInstance().achviement{
            if !PlayerDAO.getAchviements().contains(a){
                PlayerDAO.addAchviement(key: a)
            }
        }
        for k in getInstance().keys{
            if !PlayerDAO.getKeys().contains(k){
                PlayerDAO.addKey(key: k)
            }
        }
        PlayerDAO.addStatus(status:getInstance().status)
        PlayerDAO.addScene(s:getInstance().sceneInformation)
    }
    static func DeleteAll(){
        PlayerDAO.deleteEverything()
        getInstance().achviement = Set<String>()
        getInstance().keys = Set<String>()
        getInstance().status = PlayerStatus(bom: 0.0, medio: 0.0, ruim: 0.0)
        getInstance().sceneInformation = SceneInformation(previousScenario: "", actualScenario: "")
    }
}

struct PlayerStatus{
    var bom                :Float
    var medio              :Float
    var ruim               :Float
}
struct SceneInformation{
    var previousScenario   :String
    var actualScenario     :String
}
