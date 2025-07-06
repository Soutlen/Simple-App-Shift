//
//  CustomCell.swift
//  Simple-App-Shift
//
//  Created by Евгений Глоба on 7/5/25.
//

import UIKit

class CustomCell: UITableViewCell {
    static let identifier = "MainCell"
    
    lazy var HStack: UIStackView = {
        $0.axis = .horizontal
        $0.alignment = .leading
        $0.distribution = .fill
        $0.spacing = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    lazy var titleLabel: UILabel = {
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    lazy var priceLabel: UILabel = {
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        contentView.addSubview(HStack)
        HStack.addArrangedSubview(titleLabel)
        HStack.addArrangedSubview(priceLabel)
        
        NSLayoutConstraint.activate(
            [
                HStack.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
                HStack.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
                HStack.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
                HStack.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
            ]
        )
    }
    
    func configure(with model: ModelFakeStore) {
        titleLabel.text = model.title
        priceLabel.text = String(model.price)
    }
}
