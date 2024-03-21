//
//  Math.swift
//  Slender
//
//  Created by savik on 20.03.2024.
//  Copyright © 2024 Savely Nikulin. All rights reserved.
//

import Foundation

func toRadian(_ degree: CGFloat) -> CGFloat {
    return degree * .pi / 180
}

func toDegree(_ radian: CGFloat) -> CGFloat {
    return radian * 180 / .pi
}
