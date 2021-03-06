//
//  GameViewController.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 17/10/18.
//  Copyright © 2018 Abacate. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
            // Get the SKScene from the loaded GKScene
        if let scene = GKScene(fileNamed: "RoomScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! RoomScene? {
                
                // Copy gameplay related content over to the scene
                // sceneNode.entities = scene.entities
                // sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
//                    view.showsFPS = true
//                    view.showsNodeCount = true
                }
            }

            var shouldAutorotate: Bool {
        return true
    }

            var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

            var prefersStatusBarHidden: Bool {
        return true
    }
}
}
}



