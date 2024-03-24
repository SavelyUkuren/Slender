//
//  Character.swift
//  Slender
//
//  Created by savik on 20.03.2024.
//  Copyright © 2024 Savely Nikulin. All rights reserved.
//

import SceneKit

class Character: NSObject {
    
    var velocity: CGFloat = 4
    var direction: Vector2 = Vector2(x: 0, y: 0)
    
    var node: SCNNode?
    
    private var lastUpdateTime: CGFloat = 0
    
    var cameraDirection: Vector2 = Vector2(x: 0, y: 0) {
        didSet {
            if toDegree(cameraDirection.x) > 360 || toDegree(cameraDirection.x) < -360 {
                cameraDirection.x = 0
            }
            
            // If the player will enter the cursor up,
            // then put a restriction so that it does not make circles around the X-axis
            if cameraDirection.y > toRadian(90) {
                cameraDirection.y = toRadian(90)
            }
            
            if cameraDirection.y < -toRadian(90) {
                cameraDirection.y = -toRadian(90)
            }
        }
    }
    
    override init() {
        super.init()
    }
    
    init(node: SCNNode) {
        self.node = node
    }
    
    func update(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        let deltaTime = time - lastUpdateTime
        
        // DO NOT REMOVE.
        // Because, if removed, when the player moves, he will teleport the initial Y coordinate
        if let position = node?.presentation.position {
            node?.position.y = position.y
        }
        
        if !direction.isZero {
            let rotatedDirection = direction.rotateBy(angle: -cameraDirection.x).normalize
            
            node?.position.x += (rotatedDirection.x) * velocity * deltaTime
            node?.position.z += (rotatedDirection.y) * velocity * deltaTime
        }

        lastUpdateTime = time
    }
}
