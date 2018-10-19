//
//  Lista.swift
//  Shyne
//
//  Created by Ruy de Ascencão Neto on 18/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import Foundation
struct Objeto{
    var nome:String
    var mensagem:String
    var funcaoEntrada:((_ objeto:caixaDeDialogo)->Void)?
    var funcaoSaida:((_ objeto:caixaDeDialogo)->Void)?
}

var lista:[String:Objeto] = [
    "caixa":Objeto(nome: "caixa", mensagem: "...", funcaoEntrada: nil, funcaoSaida: nil)
]
