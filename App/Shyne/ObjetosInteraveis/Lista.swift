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
    var funcaoEntrada:()->Void
    var funcaoSaida:()->Void
}

var lista:[String:Objeto] = [
    "caixa":Objeto(nome: "caixa", mensagem: "Isso é uma caixa", funcaoEntrada: {print("Entrando em contato com a caixa.")}, funcaoSaida: {print("Perdendo contato com a caixa.")})
]
