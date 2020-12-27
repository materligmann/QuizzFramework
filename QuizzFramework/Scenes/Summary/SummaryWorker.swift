//
//  SummaryWorker.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import Foundation

class SummaryWorker {
    
    func getSummarySections(quizz: Quizz, onQuestionDetailRequest: @escaping (Correction) -> Void) -> [FormModels.FormSection] {
        let summary = quizz.computeSummary()
        let scoreString = "\(summary.score) / \(summary.corrections.count)"
        return [
            FormModels.FormSection(title: "General", entries: [
                FormModels.FormEntry(entryType:
                                        .text(FormModels.TextEntry(placeholder: "Score", value: scoreString)))
            ]),
            rightnessSection(corrections: summary.corrections, action: onQuestionDetailRequest)
        ]
    }
    
    func rightnessSection(corrections: [Correction], action: @escaping (_ correction: Correction) -> Void ) -> FormModels.FormSection {
        var entries = [FormModels.FormEntry]()
        for (i, correction) in corrections.enumerated() {
            let imageName = correction.rightness.isRight ? "checkmark.circle" : "xmark.circle"
            let cellAction = { action(correction) }
            let entry = FormModels.FormEntry(entryType:
                                                .result(FormModels.ResultEntry(
                                                            placeholder: "Question \(i + 1)",
                                                            image: .system(imageName),
                                                            disclosure: true,
                                                            selected: false,
                                                            action: cellAction)))
            entries.append(entry)
        }
        return FormModels.FormSection(title: "Detail", entries: entries)
    }
}
