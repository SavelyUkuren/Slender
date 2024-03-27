//
//  CGVector.swift
//  Slender
//
//  Created by savik on 26.03.2024.
//  Copyright © 2024 Savely Nikulin. All rights reserved.
//

import Foundation

extension CGPoint {
    
    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        var newVector = CGPoint(x: 0, y: 0)
        newVector.x = left.x + right.x
        newVector.y = left.y + right.y
        return newVector
    }
    
}
