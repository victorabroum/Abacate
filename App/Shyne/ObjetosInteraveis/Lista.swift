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
    var funcaoEntrada:((_ objeto:caixa)->Void)?
    var funcaoSaida:((_ objeto:caixa)->Void)?
    var interado:Bool = false
    init(nome:String,mensagem:String,funcaoEntrada:((_ objeto:caixa)->Void)?,funcaoSaida:((_ objeto:caixa)->Void)?) {
        self.nome=nome
        self.mensagem=mensagem
        self.funcaoEntrada=funcaoEntrada
        self.funcaoSaida=funcaoSaida
    }
    mutating func interagido(){
        self.interado = true
    }
}

var lista:[String:Objeto] = [
    "caixa":Objeto(nome: "caixa", mensagem: "...", funcaoEntrada: nil, funcaoSaida: nil),
    "dady":Objeto(nome: "dady", mensagem: "...", funcaoEntrada: nil, funcaoSaida: nil),
    "armario":Objeto(nome: "dady", mensagem: "...", funcaoEntrada: nil, funcaoSaida: nil),
    "triggerDad":Objeto(nome: "triggerDad", mensagem: "...", funcaoEntrada: nil, funcaoSaida: nil),
    "bakeryDoor":Objeto(nome: "bakeryDoor", mensagem: "...", funcaoEntrada: nil, funcaoSaida: nil),
    "houseDoor":Objeto(nome: "houseDoor", mensagem: "...", funcaoEntrada: nil, funcaoSaida: nil),
    "busStop":Objeto(nome: "busStop", mensagem: "...", funcaoEntrada: nil, funcaoSaida: nil),
    "triggerCloset":Objeto(nome: "triggerCloset", mensagem: "...", funcaoEntrada: nil, funcaoSaida: nil),
    "porta":Objeto(nome: "porta", mensagem: "...", funcaoEntrada: nil, funcaoSaida: nil),
    "cama":Objeto(nome: "cama", mensagem: "Quer dar uma dormidinha?\n...", funcaoEntrada: nil, funcaoSaida: nil),
    "padeiro":Objeto(nome: "cama", mensagem: "No céu tem pão.", funcaoEntrada: nil, funcaoSaida: nil),
    "professora":Objeto(nome: "professora", mensagem: "...", funcaoEntrada: nil, funcaoSaida: nil),
    "goUp":Objeto(nome: "goUp", mensagem: "...", funcaoEntrada: nil, funcaoSaida: nil),
    "goDown":Objeto(nome: "goDown", mensagem: "...", funcaoEntrada: nil, funcaoSaida: nil),
]
