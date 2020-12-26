//
//  MainWorker.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import Foundation

class MainWorker {
    func getQuizzesSections(ethQuizzAction: @escaping () -> Void) -> [FormModels.FormSection]  {
        return [
            FormModels.FormSection(
                title: nil,
                entries: [
                    FormModels.FormEntry(
                        entryType: .basic(FormModels.BasicEntry(
                                            titleLocalizedString: "Ethereum",
                                            imageName: .system("hexagon.fill"),
                                            checkMarked: false,
                                            action: ethQuizzAction,
                                            showDetailIndicator: true))
                    )
                ])
        ]
    }
}
