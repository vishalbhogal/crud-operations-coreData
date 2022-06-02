//
//  ItemTableViewCell.swift
//  coredata-demo
//
//  Created by Vishal, Bhogal (B.) on 02/06/22.
//

import Foundation
import UIKit

final class ItemTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(itemText: String) {
        itemTextLabel.text = itemText
        itemTextLabel.textColor = .white
        setupView()
    }
    
    private lazy var itemTextLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private func setupViewForCellBorder() {
        self.layer.cornerRadius = 12
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor.init(red: 192, green: 192, blue: 192, alpha: 1)
        self.backgroundColor = .random
    }
    
    private func setupView() {
        setupViewForCellBorder()
        contentView.addSubview(itemTextLabel)
        itemTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            itemTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            itemTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            itemTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
}
