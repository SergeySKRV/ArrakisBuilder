//
//  PlannewViewProtocol.swift
//  Arrakis Builder
//
//  Created by Сергей Скориков on 25.10.2025.
//

import Foundation

protocol PlannerViewProtocol: AnyObject {
    func displayParts(_ parts: [BuildingPart])
    func displayTotalResources(_ resources: Resources)
}
