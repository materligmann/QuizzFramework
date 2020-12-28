//
//  SettingsViewController.swift
//  GoGo
//
//  Created by Mathias Erligmann on 17/12/2020.
//

import UIKit

class QuestionViewController: UIViewController {
    
    private let questionTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var request: QuestionsModels.Request?
    
    private var questionViewModel: QuestionsModels.QuestionViewModel?
    
    private let interactor = QuestionInteractor()
    private let router = QuestionRouter()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureBackground()
        configureQuestionTableView()
        
        interactor.loadQuestion()
    }
    
    // MARK: Setup
    
    private func setup() {
        interactor.presenter.viewController = self
        interactor.request = request
        router.viewController = self
    }
    
    // MARK: Configure
    
    private func configureBackground() {
        view.backgroundColor = .primaryColor
    }
    
    private func configureQuestionTableView() {
        questionTableView.delegate = self
        questionTableView.dataSource = self
        questionTableView.rowHeight = UITableView.automaticDimension
        questionTableView.register(BasicCell.self, forCellReuseIdentifier: BasicCell.cellIdentifier)
        questionTableView.register(TextCell.self, forCellReuseIdentifier: TextCell.cellIdentifier)
        questionTableView.register(TextInputCell.self, forCellReuseIdentifier: TextInputCell.cellIdentifier)
        questionTableView.register(SecureInputCell.self, forCellReuseIdentifier: SecureInputCell.cellIdentifier)
        questionTableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.cellIdentifier)
        questionTableView.register(SegmentedCell.self, forCellReuseIdentifier: SegmentedCell.cellIdentifier)
        questionTableView.register(StateCell.self, forCellReuseIdentifier: StateCell.cellIdentifier)
        questionTableView.register(SwitcherCell.self, forCellReuseIdentifier: SwitcherCell.cellIdentifier)
        questionTableView.register(ResultCell.self, forCellReuseIdentifier: ResultCell.cellIdentifier)
        questionTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionTableView)
        questionTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        questionTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        questionTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        questionTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    // MARK: Navigate
    
    func navigateToNextQuestion(request: QuestionsModels.Request) {
        router.routeToNextQuestion(request: request)
    }
    
    func navigateToSummary(request: SummaryModels.Request) {
        router.routeToSummary(request: request)
    }
    
    // MARK: Display
    
    func displayTitle(title: String) {
        self.title = title
    }
    
    func displayQuestion(viewModel: QuestionsModels.QuestionViewModel) {
        questionViewModel = viewModel
        questionTableView.reloadData()
    }
    
    func displayCleanedQuestion(toggledIndexPath: IndexPath) {
        questionViewModel?.cleanChoices(for: toggledIndexPath, tableView: questionTableView)
    }
    
    func displayToggledChoice(toggledIndexPath: IndexPath) {
        questionViewModel?.toggledChoice(at: toggledIndexPath, tableView: questionTableView)
    }
}

extension QuestionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return questionViewModel?.getRowHeight(for: tableView, at: indexPath)
            ?? QuestionsModels.QuestionViewModel.basicRowHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return questionViewModel?.getNumberOfSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionViewModel?.getNumberOfRows(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return questionViewModel?.getCell(for: tableView, at: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section.questionSectionType() {
        case .first:
            break
        case .choices:
            if let choice = questionViewModel?.getSelectedChoice(at: indexPath) {
                interactor.handleChoiceSelection(choice: choice, at: indexPath)
            }
        case .last:
            questionViewModel?.onLastSelection(endAction: interactor.onQuestionEnd)
        }
    }
}
