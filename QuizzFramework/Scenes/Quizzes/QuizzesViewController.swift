//
//  QuizesViewController.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 29/12/2020.
//

import UIKit

class QuizzesViewController: UIViewController {
    
    private let quizesTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var request: QuizzesModels.Request?
    
    private var quizesViewModel: FormModels.ViewModel?
    
    private let interactor = QuizzesInteractor()
    private let router = QuizzesRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureBackground()
        configureTableView()
        
        interactor.loadQuizzes()
    }
    
    // MARK: Setup
    
    private func setup() {
        interactor.request = request
        interactor.presenter.viewController = self
        router.viewController = self
    }
    
    // MARK: Configure
    
    // MARK: Configure
    
    private func configureBackground() {
        view.backgroundColor = .systemRed
    }
    
    private func configureTableView() {
        quizesTableView.delegate = self
        quizesTableView.dataSource = self
        quizesTableView.rowHeight = 50
        quizesTableView.register(BasicCell.self, forCellReuseIdentifier: BasicCell.cellIdentifier)
        quizesTableView.register(TextCell.self, forCellReuseIdentifier: TextCell.cellIdentifier)
        quizesTableView.register(TextInputCell.self, forCellReuseIdentifier: TextInputCell.cellIdentifier)
        quizesTableView.register(SecureInputCell.self, forCellReuseIdentifier: SecureInputCell.cellIdentifier)
        quizesTableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.cellIdentifier)
        quizesTableView.register(SegmentedCell.self, forCellReuseIdentifier: SegmentedCell.cellIdentifier)
        quizesTableView.register(StateCell.self, forCellReuseIdentifier: StateCell.cellIdentifier)
        quizesTableView.register(SwitcherCell.self, forCellReuseIdentifier: SwitcherCell.cellIdentifier)
        quizesTableView.register(ResultCell.self, forCellReuseIdentifier: ResultCell.cellIdentifier)
        quizesTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quizesTableView)
        quizesTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        quizesTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        quizesTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        quizesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    // MARK: Display
    
    func displayForm(viewModel: FormModels.ViewModel) {
        self.quizesViewModel = viewModel
        quizesTableView.reloadData()
    }
    
    // MARK: Navigate
    
    func navigateToQuestion(request: QuestionsModels.Request) {
        router.routeToQuestion(request: request)
    }
}

extension QuizzesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return quizesViewModel?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return quizesViewModel?.getSectionTitle(for: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizesViewModel?.sections[section].entries.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return quizesViewModel?.getCell(at: indexPath, for: tableView) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        quizesViewModel?.onCellSelection(at: indexPath)
    }
}
