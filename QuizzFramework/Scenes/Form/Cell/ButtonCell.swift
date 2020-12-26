//
//  File.swift
//  GoGo
//
//  Created by Mathias Erligmann on 28/11/2020.
//

import UIKit

class ButtonCell: UITableViewCell {
    
    class var cellIdentifier: String {
        return "ButtonCell"
    }
    
    private let descriptionLabel = UILabel()
    private let button = UIButton()
    
    private var buttonAction: (() -> Void)?
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureButton()
        configureDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set
    
    func set(entry: FormModels.ButtonEntry) {
        switch entry.mode {
        case .enabled(let requirement):
            button.isEnabled = true
            setRequirement(requirement: requirement)
        case .disabled(let requirement):
            button.isEnabled = false
            setRequirement(requirement: requirement)
        }
    }
    
    private func setRequirement(requirement: FormModels.ButtonEntryModeRequirement) {
        self.buttonAction = requirement.buttonAction
        descriptionLabel.text = requirement.description
        button.setTitle(requirement.buttonTitle, for: .normal)
    }
    
    // MARK: Configure
    
    private func configureButton() {
        button.isEnabled = false
        button.addTarget(self, action: #selector(buttonWasPressed), for: .touchUpInside)
        button.setTitleColor(.fourthColor, for: .normal)
        button.setTitleColor(.systemGray, for: .disabled)
        button.layer.cornerRadius = 15
        button.backgroundColor = .systemGray6
        button.titleLabel?.font = .buttonFont
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(button)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel.textColor = .lightGray
        descriptionLabel.font = .placeholderFont
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
        descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
    
    // MARK: User Action
    
    @objc private func buttonWasPressed() {
        buttonAction?()
    }
}
