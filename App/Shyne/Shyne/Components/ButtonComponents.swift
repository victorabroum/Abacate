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
    
    static let doneActionNotificationName = Notification.Name(rawValue: "com.abacates.hoddy.doneActionNotificationName")
    static let continueGameNotificationName = Notification.Name("com.abacates.hoddy.continueGameNotificationName")
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func action(){
        // Resposta háptica
        let notification = UISelectionFeedbackGenerator()
        notification.selectionChanged()
    }
    
    func setup() {
        print("Setup things")
    }
    
}

class StartGameComponent: ButtonComponent{
    
    override func action() {
        super.action()
        
        NotificationCenter.default.post(name: ButtonComponent.doneActionNotificationName, object: nil)
        
        // TODO: POP-UP confirm new game
        
        // if ele confirma
        // Delte all things
//        PlayerModel.delete()
        PlayerModel.DeleteAll()
        PlayerModel.savePlayer()
        print("CHAVEs \(PlayerModel.getInstance().keys)")
        // else faz nada
        
    }
    
}

class ContinueGameComponent: ButtonComponent{
    override func action() {
        super.action()
        
        NotificationCenter.default.post(name: ButtonComponent.doneActionNotificationName, object: nil)
        
        NotificationCenter.default.post(name: ButtonComponent.continueGameNotificationName, object: nil)
        print("DA COntinue ai meu chegado!")
    }
    
    override func setup() {
        print("NOW LOAD Thing, if has something show Continue button")
    }
}

class PauseGameComponent: ButtonComponent{
    let function: (() -> Void)? = nil
    
    override func action() {
        print("PPUASEE")
        super.action()
        
        if(function != nil){
            
            function!()
        }
    }
}
