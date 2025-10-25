//
//  Resources.swift
//  Arrakis Builder
//
//  Created by Сергей Скориков on 25.10.2025.
//

import Foundation

struct Resources: Equatable {
    var metal: Int
    var energy: Int
    var water: Int
    
    static func +(lhs: Resources, rhs: Resources) -> Resources {
        return Resources(metal: lhs.metal + rhs.metal,
                         energy: lhs.energy + rhs.energy,
                         water: lhs.water + rhs.water)
    }
}
