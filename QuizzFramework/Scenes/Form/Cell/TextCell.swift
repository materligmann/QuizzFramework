//
//  TextCell.swift
//  GoGo
//
//  Created by Mathias Erligmann on 24/11/2020.
//

import UIKit

class TextCell: UITableViewCell {
    
    private let placeholderLabel = UILabel()
    private let valueLabel = UILabel()
    
    class var cellIdentifier: String {
        return "TextCell"
    }
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configurePlaceholderLabel()
        configureValueLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set
    
    func set(entry: FormModels.TextEntry) {
        placeholderLabel.text = entry.placeholder
        valueLabel.text = entry.value
    }
    
    // MARK: Configure
    
    private func configurePlaceholderLabel() {
        placeholderLabel.textColor = .lightGray
        placeholderLabel.font = .placeholderFont
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(placeholderLabel)
        placeholderLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        placeholderLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        placeholderLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
    
    private func configureValueLabel() {
        valueLabel.font = .valueFont
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(valueLabel)
        valueLabel.leftAnchor.constraint(equalTo: placeholderLabel.rightAnchor, constant: 16).isActive = true
        valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
}
