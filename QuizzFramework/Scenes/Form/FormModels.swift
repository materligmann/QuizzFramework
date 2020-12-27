//
//  FormModels.swift
//  GoGo
//
//  Created by Mathias Erligmann on 23/11/2020.
//

import UIKit

enum FormModels {
    
    // MARK: Request
    
    struct Request {
        let formTitleLocalizedString: String
        let sections: [FormSection]
        let onFormClose: (() -> Void)?
        let formAction: FormAction
        let presentation: FormPresentation
    }
    
    // MARK: FormPresentation
    
    enum FormPresentation {
        case pushed
        case presented
    }
    
    // MARK: Form Action
    
    enum FormAction {
        case yes(FormActionRequirement)
        case no
    }
    
    struct FormActionRequirement {
        let onAction: ((FormViewController) -> Void)
        let actionButtonTitle: String
        let isActionButtonEnabled: Bool
    }
    
    // MARK: Form Structure
    
    struct FormSection {
        let title: String?
        let entries: [FormEntry]
    }
    
    struct FormEntry {
        let entryType: EntryType
    }
    
    // MARK: Entry Management
    
    enum EntryType {
        case basic(BasicEntry)
        case text(TextEntry)
        case textInput(TextInputEntry)
        case secureTextInput(SecureTextInputEntry)
        case button(ButtonEntry)
        case state(StateEntry)
        case segment(SegmentEntry)
        case switcher(SwitcherEntry)
        case result(ResultEntry)
    }
    
    // MARK: Basic
    
    struct BasicEntry {
        let titleLocalizedString: String
        let imageName: BasicImage
        let checkMarked: Bool
        let action: (() -> Void)?
        let showDetailIndicator: Bool
    }
    
    enum BasicImage {
        case system(String)
        case image(String)
        case url(String)
        case none
    }
    
    // MARK: Text
    
    struct TextEntry {
        let placeholder: String
        let value: String?
    }
    
    // MARK: TextInput
    
    struct TextInputEntry {
        let defaultText: String? 
        let placeholder: String
        let onChange: (String?) -> Void
    }
    
    // MARK: SecureTextInput
    
    struct SecureTextInputEntry {
        let defaultText: String?
        let placeholder: String
        let onChange: (String?) -> Void
    }
    
    // MARK: ButtonEntry
    
    struct ButtonEntry {
        let mode: ButtonEntryMode
    }
    
    enum ButtonEntryMode {
        case enabled(ButtonEntryModeRequirement)
        case disabled(ButtonEntryModeRequirement)
    }
    
    struct ButtonEntryModeRequirement {
        let description: String
        let buttonTitle: String
        let buttonAction: (() -> Void)?
    }
    
    // MARK: StateEntry
    
    struct StateEntry {
        let placeholder: String
        let value: String
        let indicatorColor: UIColor
    }
    
    // MARK: Segment
    
    struct SegmentEntry {
        let segments: [Segment]
        let onSegmentChange: (String) -> Void
        let isEnabled: Bool
    }
    
    struct Segment {
        let name: String
        let isSelected: Bool
    }
    
    // MARK: Switcher
    
    struct SwitcherEntry {
        let titleLocalizedString: String
        let imageName: BasicImage
        let isOn: Bool
        let onSwitchAction: (Bool) -> Void
    }
    
    // MARK: Result
    
    struct ResultEntry {
        let placeholder: String
        let image: BasicImage
        let disclosure: Bool
        let selected: Bool
        let action: (() -> Void)?
    }
    
    // MARK: TableView View Model
    
    struct ViewModel {
        let sections: [FormSection]
        
        // MARK: Interface
        
        func getCell(at indexPath: IndexPath, for tableView: UITableView) -> UITableViewCell {
            let formType = sections[indexPath.section].entries[indexPath.row].entryType
            switch formType {
            case .basic(let basicEntry):
                return getBasicEntryCell(indexPath: indexPath,
                                         tableView: tableView,
                                         entry: basicEntry)
            case .text(let textEntry):
                return getTextEntryCell(indexPath: indexPath,
                                        tableView: tableView,
                                        entry: textEntry)
            case .textInput(let textInputEntry):
                return getTextInputEntryCell(indexPath: indexPath,
                                             tableView: tableView,
                                             entry: textInputEntry)
                
            case .secureTextInput(let secureTextInputEntry):
                return getSecureTextInputEntryCell(indexPath: indexPath,
                                                   tableView: tableView,
                                                   entry: secureTextInputEntry)
            case .segment(let segmentEntry):
                return getSegmentCell(indexPath: indexPath,
                                      tableView: tableView,
                                      entry: segmentEntry)
            case .button(let buttonEntry):
                return getButtonCell(indexPath: indexPath,
                                     tableView: tableView,
                                     entry: buttonEntry)
            case .state(let stateEntry):
                return getStateCell(indexPath: indexPath,
                                    tableView: tableView,
                                    entry: stateEntry)
            case .switcher(let switcherEntry):
                return getSwitcherEntryCell(indexPath: indexPath,
                                            tableView: tableView,
                                            entry: switcherEntry)
            case .result(let resultEntry):
                return getResultEntryCell(indexPath: indexPath,
                                          tableView: tableView,
                                          entry: resultEntry)
            }
        }
        
        func getSectionTitle(for section: Int) -> String? {
            return sections[section].title
        }
        
        func onCellSelection(at indexPath: IndexPath) {
            let type = sections[indexPath.section].entries[indexPath.row].entryType
            switch type {
            case .basic(let basicEntry):
                basicEntry.action?()
            case .result(let resultEntry):
                resultEntry.action?()
            default:
                break
            }
        }
        
        // MARK: Cell Management
        
        func getBasicEntryCell(indexPath: IndexPath,
                               tableView: UITableView,
                               entry: BasicEntry) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: BasicCell.cellIdentifier, for: indexPath) as? BasicCell {
                cell.set(entry: entry)
                return cell
            }
            return UITableViewCell()
        }
        
        private func getTextInputEntryCell(indexPath: IndexPath,
                                           tableView: UITableView,
                                           entry: TextInputEntry) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: TextInputCell.cellIdentifier, for: indexPath) as? TextInputCell {
                cell.set(entry: entry)
                return cell
            }
            return UITableViewCell()
        }
        
        private func getSecureTextInputEntryCell(indexPath: IndexPath,
                                           tableView: UITableView,
                                           entry: SecureTextInputEntry) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: SecureInputCell.cellIdentifier, for: indexPath) as? SecureInputCell {
                cell.set(entry: entry)
                return cell
            }
            return UITableViewCell()
        }
        
        private func getTextEntryCell(indexPath: IndexPath,
                                      tableView: UITableView,
                                      entry: TextEntry) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: TextCell.cellIdentifier, for: indexPath) as? TextCell {
                cell.set(entry: entry)
                return cell
            }
            return UITableViewCell()
        }
        
        private func getSegmentCell(indexPath: IndexPath,
                                    tableView: UITableView,
                                    entry: SegmentEntry) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: SegmentedCell.cellIdentifier, for: indexPath) as? SegmentedCell {
                cell.set(entry: entry)
                return cell
            }
            return UITableViewCell()
        }
        
        private func getButtonCell(indexPath: IndexPath,
                                    tableView: UITableView,
                                    entry: ButtonEntry) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: ButtonCell.cellIdentifier, for: indexPath) as? ButtonCell {
                cell.set(entry: entry)
                return cell
            }
            return UITableViewCell()
        }
        
        private func getStateCell(indexPath: IndexPath,
                                    tableView: UITableView,
                                    entry: StateEntry) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: StateCell.cellIdentifier, for: indexPath) as? StateCell {
                cell.set(entry: entry)
                return cell
            }
            return UITableViewCell()
        }
        
        func getSwitcherEntryCell(indexPath: IndexPath,
                               tableView: UITableView,
                               entry: SwitcherEntry) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: SwitcherCell.cellIdentifier, for: indexPath) as? SwitcherCell {
                cell.set(entry: entry)
                return cell
            }
            return UITableViewCell()
        }
        
        func getResultEntryCell(indexPath: IndexPath,
                               tableView: UITableView,
                               entry: ResultEntry) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(
                withIdentifier: ResultCell.cellIdentifier, for: indexPath) as? ResultCell {
                cell.set(entry: entry)
                return cell
            }
            return UITableViewCell()
        }
    }
}
