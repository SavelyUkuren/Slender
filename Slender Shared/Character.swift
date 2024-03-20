//
//  Character.swift
//  Slender
//
//  Created by savik on 20.03.2024.
//  Copyright © 2024 Savely Nikulin. All rights reserved.
//

import SceneKit

class Character: NSObject {
    
    var node: SCNNode?
    
    var direction: Vector2 = Vector2(x: 0, y: 0)
    
    override init() {
        super.init()
    }
    
    init(node: SCNNode) {
        self.node = node
    }
    
    func update(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // DO NOT REMOVE.
        // Because, if removed, when the player moves, he will teleport the initial Y coordinate
        if let position = node?.presentation.position {
            node?.position.y = position.y
        }
        
        if !direction.isZero {
            let normalize = direction.normalize
            node?.position.x += normalize.x / 10
            node?.position.z += normalize.y / 10
        }

    }
    
}
