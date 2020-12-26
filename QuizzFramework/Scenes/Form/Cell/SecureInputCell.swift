//
//  SecureTextInputCell.swift
//  GoGo
//
//  Created by Mathias Erligmann on 11/12/2020.
//

import UIKit

class SecureInputCell: UITableViewCell {
    
    private let textField = UITextField()
    private let rightTextFieldButton = UIButton()
    
    private var onTextFieldChange: ((String?) -> Void)?
    
    class var cellIdentifier: String {
        return "SecureInputCell"
    }
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureRightTextFieldButton()
        configureTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set
    
    func set(entry: FormModels.SecureTextInputEntry) {
        self.onTextFieldChange = entry.onChange
        textField.placeholder = entry.placeholder
        textField.text = entry.defaultText
    }
    
    // MARK: Configure
    
    private func configureRightTextFieldButton() {
        rightTextFieldButton.addTarget(self, action: #selector(eyeButtonWasPressed), for: .touchUpInside)
        rightTextFieldButton.setImage(UIImage(systemName: "eye"), for: .normal)
    }
    
    private func configureTextField() {
        textField.rightViewMode = .always
        textField.rightView = rightTextFieldButton
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textField)
        textField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        textField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
    
    // MARK: User Action
    
    @objc private func textFieldDidChange() {
        onTextFieldChange?(textField.text)
    }
    
    @objc private func eyeButtonWasPressed() {
        if textField.isSecureTextEntry {
            displayPassword()
        } else {
            hidePassword()
        }
    }
    
    // MARK: Display
    
    private func displayPassword() {
        textField.isSecureTextEntry = false
        rightTextFieldButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
    }
    
    private func hidePassword() {
        textField.isSecureTextEntry = true
        rightTextFieldButton.setImage(UIImage(systemName: "eye"), for: .normal)
    }
}
