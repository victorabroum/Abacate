//
//  StarGameComponent.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 08/01/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation
import GameplayKit

class ButtonComponent: GKComponent{
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func action(){
        print("DO SOMENTHING WOW!")
    }
    
    func setup() {
        print("Setup things")
    }
    
}

class StartGameComponent: ButtonComponent{
    
    override func action() {
        print("IZTARTA UM NEW JAME!")
    }
    
}

class ContinueGameComponent: ButtonComponent{
    override func action() {
        print("DA COntinue ai meu chegado!")
    }
    
    override func setup() {
        print("NOW LOAD Thing, if has something show Continue button")
    }
}
