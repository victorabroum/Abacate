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
    
    var backgroundMusicController: BackgroundMusicController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isMultipleTouchEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeMusic), name: changeBGMusicNotificationName, object: nil)
        
        UIApplication.shared.isIdleTimerDisabled = true
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
            // Get the SKScene from the loaded GKScene
        if let scene = GKScene(fileNamed: "RoomScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! CustomSKSCene? {
                
                // Start Background Music
                self.backgroundMusicController = BackgroundMusicController(musicName: "house")
                self.backgroundMusicController!.startMusic(withVolume: 0.1)
                
                // Copy gameplay related content over to the scene
                
                 sceneNode.entities = scene.entities
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

// MARK: Notification for change music
extension GameViewController{
    @objc func changeMusic(){
        self.backgroundMusicController?.changeMusic(to: bgMusic.name, musicExtension: bgMusic.musicExtension, withVolume: bgMusic.volume)
    }
}



