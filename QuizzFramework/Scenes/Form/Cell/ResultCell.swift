//
//  ResultCell.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 26/12/2020.
//

import UIKit

class ResultCell: UITableViewCell {
    
    private let placeholderLabel = UILabel()
    private let iconImageView = UIImageView()
    
    class var cellIdentifier: String {
        return "ResultCell"
    }
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configurePlaceholderLabel()
        configureIconImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set
    
    func set(entry: FormModels.ResultEntry) {
        placeholderLabel.text = entry.placeholder
        if entry.disclosure {
            accessoryType = .disclosureIndicator
        }
        if entry.selected {
            placeholderLabel.textColor = .fourthColor
        }
        switch entry.image {
        case .image(let name):
            iconImageView.image = UIImage(named: name)
        case .system(let name):
            iconImageView.image = UIImage(systemName: name)
        case .url:
            break
        case .none:
            break
        }
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
    
    private func configureIconImageView() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(iconImageView)
        iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor, constant: 0).isActive = true
        iconImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
    }
    
    // MARK: Process
    
    func removeSelection() {
        accessoryType = .none
    }
    
    func toggleSelection() {
        if accessoryType == .checkmark {
            accessoryType = .none
        } else {
            accessoryType = .checkmark
        }
    }
}
