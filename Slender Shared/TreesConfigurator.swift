//
//  TreesConfigurator.swift
//  Slender
//
//  Created by savik on 31.03.2024.
//  Copyright © 2024 Savely Nikulin. All rights reserved.
//

import SceneKit

class TreesConfigurator {
    
    var treeNodes: [SCNNode] = []
    
    private var tree1Positions: [SCNNode] = []
    private var tree2Positions: [SCNNode] = []
    
    init(positions: [SCNNode]) {
        
        tree1Positions = positions.filter { $0.name == "tree1Pos" }
        tree2Positions = positions.filter { $0.name == "tree2Pos" }
        
        loadTrees("Art.scnassets/TreesScene.scn")
        
    }
    
    private func loadTrees(_ scenePath: String) {
        guard let treeScene = SCNScene(named: scenePath) else {
            fatalError("Can't load trees!")
        }
        
        
        
    }
    
    private func loadLOD(scene: SCNScene, level: Int, distance: CGFloat) -> SCNLevelOfDetail? {
        
        if let treeNode = scene.rootNode.childNode(withName: "treeL\(level)", recursively: true) {
            let lod = SCNLevelOfDetail(geometry: treeNode.geometry, worldSpaceDistance: distance)
            
            return lod
        }
        
        return nil
    }
    
}
