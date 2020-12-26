//
//  BasicCell.swift
//  GoGo
//
//  Created by Mathias Erligmann on 08/12/2020.
//

import UIKit

class BasicCell: UITableViewCell {
    
    private let placeholderLabel = UILabel()
    private let valueLabel = UILabel()
    
    class var cellIdentifier: String {
        return "BasicCell"
    }
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set
    
    func set(entry: FormModels.BasicEntry) {
        textLabel?.text = entry.titleLocalizedString
        if entry.showDetailIndicator {
            accessoryType = .disclosureIndicator
        }
        
        if entry.checkMarked {
            accessoryType = .checkmark
        }
        
        switch entry.imageName {
        case .image(let name):
            imageView?.image = UIImage(named: name)
        case .system(let name):
            imageView?.image = UIImage(systemName: name)
        case .url:
            break
        case .none:
            break
        }
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
