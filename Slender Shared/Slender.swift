//
//  Slender.swift
//  Slender
//
//  Created by savik on 25.03.2024.
//  Copyright © 2024 Savely Nikulin. All rights reserved.
//

import SceneKit

class Slender: NSObject {
    
    var node: SCNNode
    
    var aroundNode: SCNNode?
    
    var spawnRadius: CGFloat = 0
    
    var scene: SCNScene?
    
    private var spawnTimer: Timer?
    
    private var height: CGFloat {
        node.boundingBox.max.y - node.boundingBox.min.y
    }
    
    init(node: SCNNode) {
        self.node = node
        
        
    }
    
    func startActivity() {
        spawnTimer = Timer.scheduledTimer(timeInterval: 5,
                                          target: self,
                                          selector: #selector(changePosition),
                                          userInfo: nil, repeats: true)
        
    }
    
    func stopActivity() {
        spawnTimer?.invalidate()
    }
    
    func update(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        
        
    }
    
    /*
     Algorithm is simple
        1) Move slender under ground to y -10
        2) Generate random 2d vector direction (x, z)
        3) Multiply direction on spawnRadius
        4) Find Slender's point of contact with the ground by beaming upwards.
        5) Seting new position
     */
    @objc private func changePosition() {
        node.position.y = -10
        
        var randomPosition: Vector2 = Vector2(x: CGFloat.random(in: -1...1),
                                              y: CGFloat.random(in: -1...1)).normalize
        
        randomPosition.x *= spawnRadius
        randomPosition.y *= spawnRadius
        
        let x: CGFloat = aroundNode!.position.x + randomPosition.x
        let z: CGFloat = aroundNode!.position.z + randomPosition.y
 
        let yNewLocation = raycastFromSlenderToGround().y + (height / 2)
        
        node.position = SCNVector3(x, yNewLocation, z)
        
    }
    
    private func raycastFromSlenderToGround() -> SCNVector3 {
        let result = scene?.rootNode.hitTestWithSegment(from: node.position, to: SCNVector3(node.position.x,
                                                                                            node.position.y + 20,
                                                                                            node.position.z))
        return result!.first!.worldCoordinates
    }
    
}
