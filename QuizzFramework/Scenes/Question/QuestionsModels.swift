//
//  SettingsModels.swift
//  GoGo
//
//  Created by Mathias Erligmann on 17/12/2020.
//

import UIKit

enum QuestionsModels {
    struct Request {
        let quizz: Quizz
    }
    
    enum QuestionSectionType {
        case question
        case choices
        case next
    }
    
    struct QuestionViewModel {
        let question: Question
        let aggregateChoices: [Choice]
        
        init(question: Question) {
            self.question = question
            self.aggregateChoices = question.getAggregatedShuffleChoice()
        }
        
        func getNumberOfSection() -> Int {
            switch question.choices.type {
            case .single:
                return 2
            case .multiple:
                return 3
            }
        }
        
        func getNumberOfRows(in section: Int) -> Int {
            switch section.questionSectionType() {
            case .question:
                return 1
            case .choices:
                return aggregateChoices.count
            case .next:
                return 1
            }
        }
        
        func getCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
            switch indexPath.section.questionSectionType() {
            case .question:
                return getQuestionCell()
            case .choices:
                return getAnswerCell(tableView: tableView, indexPath: indexPath)
            case .next:
                return getNextCell()
            }
        }
        
        private func getQuestionCell() -> UITableViewCell {
            let cell = UITableViewCell()
            cell.textLabel?.text = question.statement
            return cell
        }
        
        private func getAnswerCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
            if let cell = tableView.dequeueReusableCell(withIdentifier: BasicCell.cellIdentifier, for: indexPath) as? BasicCell {
                cell.textLabel?.text = aggregateChoices[indexPath.row].statement
                return cell
            }
            return UITableViewCell()
        }
        
        func getNextCell() -> UITableViewCell {
            let cell = UITableViewCell()
            cell.textLabel?.textAlignment = .center
            cell.contentView.backgroundColor = UIColor.fourthColor.withAlphaComponent(0.8)
            cell.textLabel?.text = "Next"
            cell.textLabel?.textColor = .primaryColor
            return cell
        }
        
        func toggledChoice(at indexPath: IndexPath, tableView: UITableView) {
            if let cell = tableView.cellForRow(at: indexPath) as? BasicCell {
                cell.toggleSelection()
            }
        }
        
        func cleanChoices(for toggledIndexPath: IndexPath, tableView: UITableView) {
            for (i, _) in aggregateChoices.enumerated() {
                if let cell = tableView.cellForRow(at: IndexPath(row: i, section: 1)) as? BasicCell,
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
            return .next
        } else {
            return .question
        }
    }
}
