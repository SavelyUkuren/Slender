//
//  GameViewController.swift
//  Slender macOS
//
//  Created by savik on 20.03.2024.
//

import Cocoa
import SceneKit

var windowFrame = NSWindow().frame

class GameViewController: NSViewController {
    
    var gameView: SCNView {
        return self.view as! SCNView
    }
    
    var gameController: GameController!
    
    private var lastMousePosition: CGPoint = .zero
    
    private var isCharacterMove = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gameController = GameController(sceneRenderer: gameView)
        // Allow the user to manipulate the camera
//        self.gameView.allowsCameraControl = true
//        self.gameView.defaultCameraController.interactionMode = .fly
        
        self.gameView.showsStatistics = true
        self.gameView.backgroundColor = NSColor.black
        self.gameView.frame = NSRect(x: 0, y: 0, width: 1024, height: 640)
        gameController.scnView = gameView
        
        addMouseTrackingArea()
        
        cursorIsHiding = true
    }
    
    override func viewDidAppear() {
//        gameView.window?.toggleFullScreen(self)
    }
    
    override func keyDown(with event: NSEvent) {
        
        var characterDirection = gameController.character!.direction
        var updateCharacter = false
        
        switch event.keyCode {
        case Keycode.w:
            characterDirection.y = -1
            updateCharacter = true
        case Keycode.a:
            characterDirection.x = -1
            updateCharacter = true
        case Keycode.s:
            characterDirection.y = 1
            updateCharacter = true
        case Keycode.d:
            characterDirection.x = 1
            updateCharacter = true
        default:
            break
        }
        
        if updateCharacter {
            gameController.character?.direction = characterDirection.isZero ? characterDirection : characterDirection.normalize
        }
        
    }
    
    override func keyUp(with event: NSEvent) {
        
        var characterDirection = gameController.character!.direction
        
        var updateCharacter = false
        
        switch event.keyCode {
        case Keycode.w:
            if characterDirection.y < 0 {
                characterDirection.y = 0
                updateCharacter = true
            }
        case Keycode.a:
            if characterDirection.x < 0 {
                characterDirection.x = 0
                updateCharacter = true
            }
        case Keycode.s:
            if characterDirection.y > 0 {
                characterDirection.y = 0
                updateCharacter = true
            }
        case Keycode.d:
            if characterDirection.x > 0 {
                characterDirection.x = 0
                updateCharacter = true
            }
        case Keycode.p:
            cursorIsHiding.toggle()
        case Keycode.r:
            gameController.character?.node?.position = SCNVector3(0, 5, 0)
            gameController.character!.cameraDirection = Vector2(x: 0, y: 0)
        default:
            break
        }
        
        if updateCharacter {
            gameController.character?.direction = characterDirection.isZero ? characterDirection : characterDirection.normalize
        }
        
    }
    
    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        
        let deltaX: CGFloat = event.deltaX
        let deltaY: CGFloat = event.deltaY
        
        gameController.character!.cameraDirection.x -= deltaX / 200
        gameController.character!.cameraDirection.y += deltaY / 200
        
    }
    
    override func mouseExited(with event: NSEvent) {
        lastMousePosition = .zero
        
    }
    
    override func mouseEntered(with event: NSEvent) {
        let currentPosition = gameView.convert(event.locationInWindow, from: nil)
        lastMousePosition = currentPosition
    }
    
    // MARK: - Private section
    private func addMouseTrackingArea() {
        
        let options: NSTrackingArea.Options = [.activeInActiveApp, .mouseMoved, .mouseEnteredAndExited]
        let trackingArea = NSTrackingArea(rect: self.gameView.bounds,
                                          options: options,
                                          owner: self)
        
        
        
        gameView.addTrackingArea(trackingArea)
    }
    
}

extension GameViewController: NSWindowDelegate {
    
}
