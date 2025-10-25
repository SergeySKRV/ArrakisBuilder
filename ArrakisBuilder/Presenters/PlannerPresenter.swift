//
//  PlannerPresenter.swift
//  Arrakis Builder
//
//  Created by Сергей Скориков on 25.10.2025.
//

import Foundation

final class PlannerPresenter {
    private var selectedParts: [BuildingPart] = []
    weak var view: PlannerViewProtocol?

    func attachView(_ view: PlannerViewProtocol) {
        self.view = view
        updateView()
    }

    func addPart(_ part: BuildingPart) {
        selectedParts.append(part)
        updateView()
    }

    func removePart(at index: Int) {
        guard selectedParts.indices.contains(index) else { return }
        selectedParts.remove(at: index)
        updateView()
    }
    
    private func updateView() {
        view?.displayParts(selectedParts)
        let totalResources = selectedParts.reduce(Resources(metal: 0, energy: 0, water: 0)) { $0 + $1.resources }
        view?.displayTotalResources(totalResources)
    }
}
