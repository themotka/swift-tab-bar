//
//  TableViewController.swift
//  less1
//
//  Created by Aleksandr Grachev on 14.10.2024.
//

import UIKit

final class TableViewController: UIViewController {
    
    private enum TableViewSectionType: Int, CaseIterable {
        case goods = 0
        case products = 1
    }
    
    private let data = ["Товар 1", "Товар 2", "Товар 3"]
    private var data2 = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        Task { [weak self] in
            guard let self else { return }
            
            do {
                print("Старт")
                try await Task.sleep(for: .seconds(3))
                data2 = ["Продукт 1", "Продукт 2", "Продукт 3"]
                print("Стоп")
            } catch {
                print(error)
            }
        }
    }
    
    private func configureUI() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension TableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        TableViewSectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = TableViewSectionType(rawValue: section) else {
            return 0
        }
        
        switch section {
        case .goods:
            return data.count
        case .products:
            return data2.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = TableViewSectionType(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch section {
        case .goods:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = data[indexPath.row]
            return cell
            
        case .products:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CustomTableViewCell.identifier,
                for: indexPath
            ) as? CustomTableViewCell else { return UITableViewCell() }
            
            cell.configre(with: data2[indexPath.row]) {
                print(indexPath.row)
            }
            
            return cell
        }
    }
}

extension TableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let section = TableViewSectionType(rawValue: indexPath.section) else { return }
        
        switch section {
        case .goods:
            print("Товар \(indexPath.row)")
        case .products:
            print("Продукт \(indexPath.row)")
        }
    }
}

