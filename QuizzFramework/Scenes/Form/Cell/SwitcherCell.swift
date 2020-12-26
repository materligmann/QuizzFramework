//
//  SwitchCell.swift
//  GoGo
//
//  Created by Mathias Erligmann on 23/12/2020.
//

import UIKit

class SwitcherCell: UITableViewCell {
    
    private let placeholderLabel = UILabel()
    private let valueLabel = UILabel()
    private let switcher = UISwitch()
    
    private var switcherAction: ((Bool) -> Void)?
    
    class var cellIdentifier: String {
        return "SwitcherCell"
    }
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSwitcher()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set
    
    func set(entry: FormModels.SwitcherEntry) {
        switcherAction = entry.onSwitchAction
        switcher.setOn(entry.isOn, animated: false)
        textLabel?.text = entry.titleLocalizedString.localized()
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
    
    // MARK: Configure
    
    private func configureSwitcher() {
        switcher.addTarget(self, action: #selector(onSwitcherValueChanged), for: .valueChanged)
        switcher.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(switcher)
        switcher.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        switcher.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
    }
    
    // MARK: User Action
    
    @objc private func onSwitcherValueChanged() {
        switcherAction?(switcher.isOn)
    }
}
