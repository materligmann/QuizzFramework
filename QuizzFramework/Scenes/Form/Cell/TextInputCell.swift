//
//  FormTextInputCell.swift
//  GoGo
//
//  Created by Mathias Erligmann on 24/11/2020.
//

import UIKit

class TextInputCell: UITableViewCell {
    
    private let textField = UITextField()
    private var onTextFieldChange: ((String?) -> Void)?
    
    class var cellIdentifier: String {
        return "TextInputCell"
    }
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set
    
    func set(entry: FormModels.TextInputEntry) {
        self.onTextFieldChange = entry.onChange
        textField.placeholder = entry.placeholder
        textField.text = entry.defaultText
    }
    
    // MARK: Configure
    
    private func configureTextField() {
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
}
