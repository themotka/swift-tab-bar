//
//  CollectionViewController.swift
//  less1
//
//  Created by Aleksandr Grachev on 14.10.2024.
//

import UIKit

final class CollectionViewController: UIViewController {
    
    private enum CollectionSectionType: Int, CaseIterable {
        case goods = 0
        case products = 1
    }
    
    private let data = ["Товар 1", "Товар 2", "Товар 3", "Товар 4", "Товар 5"]
    private var data2 = ["Товар 1", "Товар 2", "Товар 3", "Товар 1", "Товар 2", "Товар 3", "Товар 1", "Товар 2", "Товар 3", "Товар 1", "Товар 2", "Товар 3", "Товар 1", "Товар 2", "Товар 3", "Товар 1", "Товар 2", "Товар 3"]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let section = CollectionSectionType(rawValue: indexPath.section) else {
            return CGSize.zero
        }
        
        switch section {
        case .goods:
            return CGSize(width: view.frame.width / 3, height: 50)
        case .products:
            return CGSize(width: 100, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        guard let section = CollectionSectionType(rawValue: section) else {
            return UIEdgeInsets.zero
        }
        
        switch section {
        case .goods:
            return UIEdgeInsets(top: 32, left: 16, bottom: 0, right: 16)
        case .products:
            return UIEdgeInsets(top: 32, left: 16, bottom: 0, right: 16)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        CollectionSectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = CollectionSectionType(rawValue: section) else { return 0 }
        
        switch section {
        case .goods:
            return data.count
        case .products:
            return data2.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let section = CollectionSectionType(rawValue: indexPath.section) else { return UICollectionViewCell() }
        
        switch section {
        case .goods:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "collectionCell",
                for: indexPath
            )
            cell.contentView.backgroundColor = .lightGray
            return cell
            
        case .products:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "collectionCell",
                for: indexPath
            )
            cell.contentView.backgroundColor = .blue
            return cell
        }
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print()
    }
}
