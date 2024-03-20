//
//  GameViewController.swift
//  Slender macOS
//
//  Created by savik on 20.03.2024.
//

import Cocoa
import SceneKit

class GameViewController: NSViewController {
    
    var gameView: SCNView {
        return self.view as! SCNView
    }
    
    var gameController: GameController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gameController = GameController(sceneRenderer: gameView)
        
        // Allow the user to manipulate the camera
//        self.gameView.allowsCameraControl = true
        
        // Show statistics such as fps and timing information
        self.gameView.showsStatistics = true
        
        // Configure the view
        self.gameView.backgroundColor = NSColor.black
        
        self.gameView.frame = NSRect(x: 0, y: 0, width: 1024, height: 640)
        
    }
    
    override func keyDown(with event: NSEvent) {
        
        switch event.keyCode {
        case Keycode.w:
            self.gameController.character?.direction.y = -1
        case Keycode.a:
            self.gameController.character?.direction.x = -1
        case Keycode.s:
            self.gameController.character?.direction.y = 1
        case Keycode.d:
            self.gameController.character?.direction.x = 1
        default:
            break
        }
    }
    
    override func keyUp(with event: NSEvent) {
        
        switch event.keyCode {
        case Keycode.w:
            self.gameController.character?.direction.y = 0
        case Keycode.a:
            self.gameController.character?.direction.x = 0
        case Keycode.s:
            self.gameController.character?.direction.y = 0
        case Keycode.d:
            self.gameController.character?.direction.x = 0
        default:
            break
        }
    }
    
}
