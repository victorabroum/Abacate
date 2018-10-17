//
//  TouchController.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 17/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import SpriteKit

class TouchController: SKSpriteNode {
    
    var rigth_button = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 50, height: 50))
    var left_button = SKSpriteNode(color: UIColor.orange, size: CGSize(width: 50, height: 50))

    init(frame: CGRect) {
        super.init(texture: nil, color: UIColor.clear, size: frame.size)
        
        setupControl(size: frame.size)
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupControl(size: CGSize){
        addButton(button: rigth_button, position: CGPoint(x: 0, y: 0) , name: "rigth", scale: 1.0)
        addButton(button: left_button, position: CGPoint(x: 100, y: 0) , name: "left", scale: 1.0)

    }
    
    func addButton(button: SKSpriteNode,
                   position: CGPoint,
                   name: String,
                   scale: CGFloat) -> (){
    
        button.position = position
        button.name = name
        button.setScale(scale)
        button.zPosition = zPositionToButton
        
        self.addChild(button)
    }
    
}
