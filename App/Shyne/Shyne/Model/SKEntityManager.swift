//
//  SKEntityManager.swift
//  Shyne
//
//  Created by Victor Vasconcelos on 13/12/19.
//  Copyright © 2019 Abacate. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class SKEntityManager {

    public static var shared = SKEntityManager()
    
    /// Set of All entities in game, this should the only place of the entity is strong reference
    private(set) var entities = Set<GKEntity>()
    
    /// Set for control entities to remove
    private var toRemove = Set<GKEntity> ()
    
    /// All components systems
    // Insert any entity that needs updating here as a GKComponentSystem
    lazy private var componentSystems: [GKComponentSystem] = {
        return [ ]
    }()

    init() { }
    
    /// To Add an Entity
    public func add(_ entity: GKEntity) {
        
        self.entities.insert(entity)
        
        // Add rigth components systems
        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
        
    }
    
    /// To Remove an Entity
    public func remove(_ entity: GKEntity) {
        self.toRemove.insert(entity)
    }
    
    /// To remove all entities
    public func removeAll() {
        for entity in self.entities {
            self.toRemove.insert(entity)
        }
    }
    
    public func update(_ deltaTime: CFTimeInterval) {
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: deltaTime)
        }
        
        // Update Components in System
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: deltaTime)
        }
        
        // Remove right component
        for currentRemove in toRemove {
            for componentSystem in componentSystems {
                componentSystem.removeComponent(foundIn: currentRemove)
            }
            entities.remove(currentRemove)
        }
        toRemove.removeAll()
    }
}
