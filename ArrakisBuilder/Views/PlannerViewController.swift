//
//  PlannerViewController.swift
//  Arrakis Builder
//
//  Created by Сергей Скориков on 25.10.2025.
//

import UIKit

final class PlannerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PlannerViewProtocol {

    private let presenter = PlannerPresenter()
    private var parts: [BuildingPart] = []
    private let tableView = UITableView()
    private let summaryLabel = UILabel()
    private let addButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        setupUI()
    }

    private func setupUI() {
        title = "Планировщик базы"
        view.backgroundColor = .white

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false

        summaryLabel.numberOfLines = 0
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false

        addButton.setTitle("Добавить тестовую часть", for: .normal)
        addButton.addTarget(self, action: #selector(addPartTapped), for: .touchUpInside)
        addButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)
        view.addSubview(summaryLabel)
        view.addSubview(addButton)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),

            summaryLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            summaryLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            summaryLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

            addButton.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 20),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }

    @objc private func addPartTapped() {
        let testPart = BuildingPart(id: "wall_01", name: "Стена - Базовая", resources: Resources(metal:50, energy: 10, water: 5))
        presenter.addPart(testPart)
    }

    //MARK: - PlannerViewProtocol
    func displayParts(_ parts: [BuildingPart]) {
        self.parts = parts
        tableView.reloadData()
    }

    func displayTotalResources(_ resources: Resources) {
        summaryLabel.text = """
            Итоговые ресурсы:
            Металл: \(resources.metal)
            Энергия: \(resources.energy)
            Вода: \(resources.water)
            """
    }

    //MARK: - UITableViewDataSource & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        parts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let part = parts[indexPath.row]
        cell.textLabel?.text = "\(part.name) - Металл: \(part.resources.metal), Энергия: \(part.resources.energy), Вода: \(part.resources.water)"
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.removePart(at: indexPath.row)
        }
    }
}
