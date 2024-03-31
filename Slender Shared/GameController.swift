//
//  GameController.swift
//  Slender Shared
//
//  Created by savik on 20.03.2024.
//

import SceneKit

#if os(macOS)
    typealias SCNColor = NSColor

    var cursorIsHiding = false {
        didSet {
            if cursorIsHiding == true {
                NSCursor.hide()
            } else {
                NSCursor.unhide()
            }
        }
    }

#else
    typealias SCNColor = UIColor
#endif

class GameController: NSObject, SCNSceneRendererDelegate {

    let scene: SCNScene
    let sceneRenderer: SCNSceneRenderer
    
    var scnView: SCNView?
    
    var character: Character?
    var camera: SCNNode?
    
    var slender: Slender?
    
    private var pages: [SCNNode] = []
    
    private var treeConfigurator: TreesConfigurator?
    
    init(sceneRenderer renderer: SCNSceneRenderer) {
        sceneRenderer = renderer
        scene = SCNScene(named: "Art.scnassets/MainScene.scn")!
        
        super.init()
        
        sceneRenderer.delegate = self
        sceneRenderer.scene = scene
        scene.physicsWorld.contactDelegate = self
        
        loadCharacter()
        loadCamera()
        loadPages()
        loadSlender()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if cursorIsHiding {
            lockCursorAtCenter()
        }
        
        cameraUpdate()
        character?.update(renderer, updateAtTime: time)
    }

    // MARK: Private section
    private func loadCharacter() {
        if let characterNode = scene.rootNode.childNode(withName: "character", recursively: true) {
            characterNode.physicsBody?.categoryBitMask = PhysicsCategories.Character
            characterNode.physicsBody?.collisionBitMask = PhysicsCategories.Collision
            character = Character(node: characterNode)
        }
    }
    
    private func loadCamera() {
        if let cameraNode = scene.rootNode.childNode(withName: "camera", recursively: true) {
            camera = cameraNode
        }
    }
    
    private func lockCursorAtCenter() {
        guard let scnView = scnView else {
            fatalError("Error. ScnView is nil")
        }
        
        DispatchQueue.main.async {
            let cursorPosition = CGPoint(x: scnView.frame.midX,
                                         y: scnView.frame.midY)
            CGWarpMouseCursorPosition(cursorPosition)
            
        }
    }
    
    private func loadPages() {
        pages = scene.rootNode.childNodes.filter({ $0.name == "page" })
        
        pages.forEach { page in
            if let sphereTrigger = page.childNode(withName: "collisionSphere", recursively: true) {
                sphereTrigger.physicsBody?.categoryBitMask = PhysicsCategories.Page
                sphereTrigger.physicsBody?.collisionBitMask = PhysicsCategories.Character
                sphereTrigger.physicsBody?.contactTestBitMask = PhysicsCategories.Character
            }
        }
    }
    
    private func loadSlender() {
        if let slenderNode = scene.rootNode.childNode(withName: "Slender", recursively: true) {
            
            slender = Slender(node: slenderNode)
            slender?.spawnRadius = 10
            slender?.scene = scene
            slender?.aroundNode = character?.node
            
            slender?.startActivity()
            
        }
    }
    
    private func cameraUpdate() {
        camera?.eulerAngles.x = -character!.cameraDirection.y
        camera?.eulerAngles.y = character!.cameraDirection.x
    }
    
    private func collectPage(_ page: SCNNode) {
        character?.collectedPages += 1
        
        if let overlay = scnView?.overlaySKScene as? GameOverlayMacOS {
            overlay.updateCollectedPagesLabel(pages: character!.collectedPages)
        }
        
        pages.removeAll(where: { $0 == page })
        page.removeFromParentNode()
    }
    
}

extension GameController: SCNPhysicsContactDelegate {
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        let collision = contact.nodeA.physicsBody!.categoryBitMask | contact.nodeB.physicsBody!.categoryBitMask
        
        switch collision {
        case PhysicsCategories.Character | PhysicsCategories.Page:
            
            if let overlay = scnView?.overlaySKScene as? GameOverlayMacOS {
                overlay.updateCollectedPagesLabel(pages: character!.collectedPages)
            }
            
            let collisionSphere = contact.nodeA.name == "collisionSphere" ? contact.nodeA : contact.nodeB
            let parentNode = collisionSphere.parent
            
            collectPage(parentNode!)
            
        default:
            break
        }
        
    }
}
