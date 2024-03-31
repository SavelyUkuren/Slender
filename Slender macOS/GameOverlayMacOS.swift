//
//  GameOverlayController.swift
//  Slender
//
//  Created by savik on 25.03.2024.
//  Copyright © 2024 Savely Nikulin. All rights reserved.
//

import SpriteKit

class GameOverlayMacOS: SKScene {
    
    enum HintAlignment: Int {
        case center
    }
    
    var gameView: NSViewController?
    
    var collectedPagesLabel: SKLabelNode?
    var hintLabel: SKLabelNode?
    
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = SCNColor.red
        
        configureCollectedPagesLabel()
        configureHintLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        print("Init decoder")
    }
    
    override func keyDown(with event: NSEvent) {
        gameView?.keyDown(with: event)
    }
    
    override func keyUp(with event: NSEvent) {
        gameView?.keyUp(with: event)
    }
    
    func showHint(text: String, at alignment: HintAlignment, offset: CGPoint? = nil) {
        
        var position = CGPoint(x: 0, y: 0)
        
        switch alignment {
        case .center:
            position = CGPoint(x: size.width / 2,
                               y: size.height / 2)
        }
        
        if let offset = offset {
            position = position + offset
        }
        
        hintLabel?.text = text
        hintLabel?.position = position
        hintLabel?.alpha = 1
    }
    
    func hideHint() {
        hintLabel?.alpha = 0
    }
    
    func updateCollectedPagesLabel(pages: Int) {
        collectedPagesLabel?.text = "Collected pages: \(pages)"
    }
    
    // MARK: - Private section
    private func configureCollectedPagesLabel() {
        collectedPagesLabel = SKLabelNode(text: "Collected pages: 0")
        collectedPagesLabel?.fontName = "SFPro-Meduim"
        collectedPagesLabel?.fontSize = 24
        collectedPagesLabel?.horizontalAlignmentMode = .left
        
        collectedPagesLabel?.position = CGPoint(x: 8,
                                                y: size.height - collectedPagesLabel!.frame.maxY - 8)
        
        addChild(collectedPagesLabel!)
    }
    
    private func configureHintLabel() {
        hintLabel = SKLabelNode(text: "")
        hintLabel?.fontName = "SFPro-Meduim"
        hintLabel?.fontSize = 20
        hintLabel?.horizontalAlignmentMode = .center
        
        hintLabel?.position = CGPoint(x: size.width / 2,
                                      y: size.height / 2)
        
        addChild(hintLabel!)
    }
    
}
