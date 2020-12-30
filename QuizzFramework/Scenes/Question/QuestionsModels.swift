//
//  SettingsModels.swift
//  GoGo
//
//  Created by Mathias Erligmann on 17/12/2020.
//

import UIKit

enum QuestionsModels {
    struct Request {
        let mode: QuestionMode
        let title: String
        let isSkippable: Bool
    }
    
    enum QuestionMode {
        case question(Question)
        case correction(Correction)
    }
    
    enum QuestionSectionType {
        case first
        case choices
        case last
    }
    
    struct QuestionViewModel {
        let question: Question
        let aggregateChoices: [Choice]
        let rightness: Rightness?
        
        var disabledCellSelection = false
        
        let multipleQuestionNumberOfSetcion = 3
        let correctionNumberOfSection = 2
        
        static let basicRowHeight: CGFloat = 50
        
        init(question: Question, rightness: Rightness?) {
            self.question = question
            self.aggregateChoices = question.getAggregatedShuffleChoice()
            self.rightness = rightness
        }
        
        func getRowHeight(for tableView: UITableView, at indexPath: IndexPath) -> CGFloat {
            switch indexPath.section.questionSectionType() {
            case .first:
                return Self.basicRowHeight
            case .choices:
                return Self.basicRowHeight
            case .last:
                if rightness != nil {
                    return UITableView.automaticDimension
                } else {
                    return Self.basicRowHeight
                }
            }
        }
        
        func getNumberOfSection() -> Int {
            switch (question.choices.type, rightness) {
            case (.multiple, nil):
                return 3
            case (.single, nil):
                return 3
            default:
                return 3
            }
        }
        
        func getNumberOfRows(in section: Int) -> Int {
            switch section.questionSectionType() {
            case .first:
                return 1
            case .choices:
                return aggregateChoices.count
            case .last:
                return 1
            }
        }
        
        func getCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
            switch indexPath.section.questionSectionType() {
            case .first:
                return getQuestionCell()
            case .choices:
                return getAnswerCell(tableView: tableView,
                                     indexPath: indexPath)
            case .last:
                if rightness != nil {
                    let cell = UITableViewCell()
                    cell.textLabel?.text = question.explanation
                    cell.textLabel?.numberOfLines = 0
                    return cell
                } else {
                    return getNextCell()
                }
            }
        }
        
        mutating func onLastSelection(endAction: () -> Void) {
            if rightness == nil {
                endAction()
            }
        }
        
        private func getQuestionCell() -> UITableViewCell {
            let cell = UITableViewCell()
            cell.textLabel?.text = question.statement
            return cell
        }
        
        private func getAnswerCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: ResultCell.cellIdentifier, for: indexPath) as? ResultCell {
                var image: FormModels.BasicImage?
                if let rightness = rightness {
                    let correct = rightness.checks[indexPath.row].isCorrect
                    image = .system(correct ? "checkmark.circle" : "xmark.circle")
                } else {
                    image = FormModels.BasicImage.none
                }
                let choice = aggregateChoices[indexPath.row]
                cell.set(entry: FormModels.ResultEntry(placeholder: choice.statement,
                                                       image: image!,
                                                       disclosure: false,
                                                       selected: rightness?.checks[indexPath.row].selected ?? false,
                                                       action: nil))
                return cell
            }
            return UITableViewCell()
        }
        
        private func getNextCell() -> UITableViewCell {
            let cell = UITableViewCell()
            cell.textLabel?.textAlignment = .center
            cell.contentView.backgroundColor = UIColor.fourthColor.withAlphaComponent(0.8)
            cell.textLabel?.text = "Next"
            cell.textLabel?.textColor = .primaryColor
            return cell
        }
        
        func toggledChoice(at indexPath: IndexPath, tableView: UITableView) {
            if let cell = tableView.cellForRow(at: indexPath) as? ResultCell {
                cell.toggleSelection()
            }
        }
        
        func cleanChoices(for toggledIndexPath: IndexPath, tableView: UITableView) {
            for (i, _) in aggregateChoices.enumerated() {
                if let cell = tableView.cellForRow(at: IndexPath(row: i, section: 1)) as? ResultCell,
                   i != toggledIndexPath.row {
                    cell.removeSelection()
                }
            }
        }
        
        func getSelectedChoice(at indexPath: IndexPath) -> Choice {
            return aggregateChoices[indexPath.row]
        }
    }
}

extension Int {
    func questionSectionType() -> QuestionsModels.QuestionSectionType {
        if self == 1 {
            return .choices
        } else if self == 2 {
            return .last
        } else {
            return .first
        }
    }
}
