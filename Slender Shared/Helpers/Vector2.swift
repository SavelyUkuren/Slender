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
        let newVector = Vector2(x: self.x / length, y: y / length)
        return newVector
    }
}
