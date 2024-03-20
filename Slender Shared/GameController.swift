//
//  GameController.swift
//  Slender Shared
//
//  Created by savik on 20.03.2024.
//

import SceneKit

#if os(macOS)
    typealias SCNColor = NSColor
#else
    typealias SCNColor = UIColor
#endif

class GameController: NSObject, SCNSceneRendererDelegate {

    let scene: SCNScene
    let sceneRenderer: SCNSceneRenderer
    
    var character: Character?
    
    init(sceneRenderer renderer: SCNSceneRenderer) {
        sceneRenderer = renderer
        scene = SCNScene(named: "Art.scnassets/MainScene.scn")!
        
        super.init()
        
        sceneRenderer.delegate = self
        sceneRenderer.scene = scene
        
        loadCharacter()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
        
        character?.update(renderer, updateAtTime: time)
    }

    // MARK: Private section
    private func loadCharacter() {
        if let characterNode = scene.rootNode.childNode(withName: "character", recursively: true) {
            character = Character(node: characterNode)
        }
    }
    
}
