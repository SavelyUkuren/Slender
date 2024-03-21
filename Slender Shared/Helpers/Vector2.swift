//
//  Vector2.swift
//  Slender
//
//  Created by savik on 20.03.2024.
//  Copyright © 2024 Savely Nikulin. All rights reserved.
//

import Foundation

struct Vector2 {
    var x: CGFloat
    var y: CGFloat
    
    var isZero: Bool {
        x == 0 && y == 0
    }
    
    var normalize: Vector2 {
        let length = sqrt(x * x + y * y)
            let newVector = Vector2(x: self.x / length, y: self.y / length)
            return newVector
    }
    
    // The adopted parameter is calculated in radians
    func rotateBy(angle: CGFloat) -> Vector2 {
        var result = self
        
        let cosAngle = cos(angle)
        let sinAngle = sin(angle)
        
        let newX = result.x * cosAngle - result.y * sinAngle
        let newY = result.x * sinAngle + result.y * cosAngle
        
        result.x = newX
        result.y = newY
        
        return result
    }
    
    static func +(vec1: Vector2, vec2: Vector2) -> Vector2 {
        var result = Vector2(x: 0, y: 0)
        
        result.x = vec1.x + vec2.x
        result.y = vec1.y + vec2.y
        
        return result
    }
}
