//
//  SummaryWorker.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import Foundation

class SummaryWorker {
    
    func getSummarySections(quizz: Quizz) -> [FormModels.FormSection] {
        let summary = quizz.computeSummary()
        let scoreString = "\(summary.score) / \(summary.numberOfQuestions)"
        return [
            FormModels.FormSection(title: "General", entries: [
                FormModels.FormEntry(entryType:
                                        .text(FormModels.TextEntry(placeholder: "Score", value: scoreString)))
            ]),
            rightnessSection(rightnesses: summary.rightnesses)
        ]
    }
    
    func rightnessSection(rightnesses: [Rightness]) -> FormModels.FormSection {
        var entries = [FormModels.FormEntry]()
        for (i, rightness) in rightnesses.enumerated() {
            let value = rightness.isRight ? "Correct" : "Incorrect"
            let entry = FormModels.FormEntry(entryType:
                                                .text(FormModels.TextEntry(placeholder: "Question \(i + 1)",
                                                                           value: value)))
            entries.append(entry)
        }
        return FormModels.FormSection(title: "Detail", entries: entries)
    }
}
