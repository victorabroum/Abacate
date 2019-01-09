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
    var status:PlayerStatus?
    private static var player:PlayerModel?
    private init(){
        achviement = Set<String>(PlayerDAO.getAchviements())
        keys = Set<String>(PlayerDAO.getKeys())
        status = PlayerDAO.getStatus()[0]
    }
    static func getInstance() -> PlayerModel{
        if(player == nil){
            player = PlayerModel()
        }
        return player!
    }
    static func incrementStatusBom(increment:Float){
        getInstance().status?.bom+=increment
    }
    static func incrementStatusMedio(increment:Float){
        getInstance().status?.medio+=increment
    }
    static func incrementStatusRuim(increment:Float){
        getInstance().status?.ruim+=increment
    }
    static func addAchviement(ach:String){
        getInstance().achviement.insert(ach)
    }
    static func addKeys(k:String){
        getInstance().keys.insert(k)
    }
    static func savePlayer(){
        //salvar status
//        PlayerDAO.updateStatus(status: self.getInstance().status!)
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
//        PlayerDAO.updateStatus(status: getInstance().status!)
    }

}

struct PlayerStatus{
    var bom:Float
    var medio:Float
    var ruim:Float
}
