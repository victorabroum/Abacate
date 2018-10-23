//
//  TouchController.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 17/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import SpriteKit

class TouchController: SKSpriteNode {
    
    var right_button = SKSpriteNode()
    var left_button = SKSpriteNode()
    
    var arrayOfButtons = [SKSpriteNode]()
    
    var touchControlDelegate : TouchControlDelegate?

    init(frame: CGRect) {
        super.init(texture: nil, color: UIColor.clear, size: frame.size)
        
        // Initialize right button
        right_button = SKSpriteNode(texture: nil, color: UIColor.blue, size: CGSize(width: frame.size.width/2, height: frame.size.height))
        // Set anchorPoint
        right_button.anchorPoint = CGPoint(x: 0, y: 0.5)
        // Set alpha 0 for this button
        right_button.alpha = 0
        
        // Initialize left button
        left_button = SKSpriteNode(texture: nil, color: UIColor.orange, size: CGSize(width: frame.size.width/2, height: frame.size.height))
        // Set anchorPoint
        left_button.anchorPoint = CGPoint(x: 1, y: 0.5)
        // Set alpha 0 for this button
        left_button.alpha = 0
        
        // Call setup controls
        setupControl(size: frame.size)
        
        // Say the buttons now is avalible to touch
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupControl(size: CGSize){
        addButton(button: right_button, position: CGPoint(x: 0, y: 0) , name: "right", scale: 1.0)
        addButton(button: left_button, position: CGPoint(x: 0, y: 0) , name: "left", scale: 1.0)

    }
    
    func addButton(button: SKSpriteNode,
                   position: CGPoint,
                   name: String,
                   scale: CGFloat){
    
        button.position = position
        button.name = name
        button.setScale(scale)
        button.zPosition = zPositionToButton
        
        self.addChild(button)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            let location = t.location(in: parent!)
            
            for button in [right_button, left_button]{
                // Se o clique foi no botão
                // *E* é o primiero clique
                if button.contains(location) && !arrayOfButtons.contains(button){
                    arrayOfButtons.append(button)
                    if(touchControlDelegate != nil){
                        touchControlDelegate?.follow(command: button.name!)
                    }
                }
            }
        }
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            let location = t.location(in: parent!)
            let previousLocation = t.previousLocation(in: parent!)

            for button in [right_button, left_button]{
                if button.contains(previousLocation) && !button.contains(location){
                    let index = arrayOfButtons.contains(button)
                    if index{
                        arrayOfButtons.removeAll()
                        touchControlDelegate?.follow(command: "cancel \(button.name!)")
                    }
                }else if !button.contains(previousLocation) && button.contains(location){
                    arrayOfButtons.append(button)
                    if(touchControlDelegate != nil){
                        touchControlDelegate?.follow(command: button.name!)
                    }
                }else if button.contains(previousLocation) && button.contains(location){
                    if(touchControlDelegate != nil){
                        touchControlDelegate?.follow(command: button.name!)
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches{
            let location = t.location(in: parent!)
            let previousLocation = t.location(in: parent!)
            
            for button in [right_button, left_button]{
                if button.contains(location) || button.contains(previousLocation){
                    if arrayOfButtons.contains(button){
                        arrayOfButtons.removeAll()
                        if touchControlDelegate != nil{
                            touchControlDelegate?.follow(command: "idle")
                        }
                    }
                }
            }
        }
        
    }
    
    func touchUp(touches: Set<UITouch>?, withEvent event: UIEvent){
        for t in touches!{
            let location = t.location(in: parent!)
            let previousLocation = t.location(in: parent!)
            
            for button in [right_button, left_button]{
                if button.contains(location) || button.contains(previousLocation){
                    if arrayOfButtons.contains(button){
                        arrayOfButtons.removeAll()
                        if touchControlDelegate != nil{
                            touchControlDelegate?.follow(command: "cancel \(button.name!)")
                        }
                    }
                }
            }
        }
    }
    
}
