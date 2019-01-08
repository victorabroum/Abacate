//
//  PlayerModel.swift
//  Shyne
//
//  Created by Ruy de Ascencão Neto on 08/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation

class PlayerModel{
    
    var Achviement:Set<String>
    var keys:Set<String>
    var status:PlayerStatus?
    private static var player:PlayerModel?
    private init(){
        Achviement = Set<String>(PlayerDAO.getAchviements())
        keys = Set<String>(PlayerDAO.getKeys())
        status = PlayerDAO.getStatus()[0]
    }
    static func getInstance() -> PlayerModel{
        if(player == nil){
            player = PlayerModel()
        }
        return player!
    }
}
struct PlayerStatus{
    var bom:Float
    var medio:Float
    var ruim:Float
}
