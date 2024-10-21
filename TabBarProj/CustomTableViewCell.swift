//
//  CustomTableViewCell.swift
//  less1
//
//  Created by Aleksandr Grachev on 14.10.2024.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    private var buttonAction: (() -> Void)?
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tap", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addAction(
            .init { [weak self] _ in
                self?.buttonAction?()
            },
            for: .touchUpInside
        )
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configre(with text: String, action: (() -> Void)?) {
        label.text = text
        buttonAction = action
    }
    
    private func configureUI() {
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 30),
            button.heightAnchor.constraint(equalToConstant: 30),
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100)
        ])
        
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
