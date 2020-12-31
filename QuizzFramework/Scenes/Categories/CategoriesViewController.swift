//
//  MainViewController.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    private let mainTableView = UITableView(frame: .zero, style: .insetGrouped)
    private let newQuizButton = UIBarButtonItem()
    
    var request: CategoriesModels.Request?
    
    private var mainViewModel: FormModels.ViewModel?
    
    private let interactor = CategoriesInteractor()
    private let router = CategoriesRouter()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureBackground()
        configureTitle()
        configureSummaryTableView()
        if Settings.addQuizz {
            configureNewQuizzButton()
        }
        
        interactor.loadCategories()
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
    
    private func configureTitle() {
        title = "Knowledge Proof"
    }
    
    private func configureSummaryTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.rowHeight = 50
        mainTableView.register(BasicCell.self, forCellReuseIdentifier: BasicCell.cellIdentifier)
        mainTableView.register(TextCell.self, forCellReuseIdentifier: TextCell.cellIdentifier)
        mainTableView.register(TextInputCell.self, forCellReuseIdentifier: TextInputCell.cellIdentifier)
        mainTableView.register(SecureInputCell.self, forCellReuseIdentifier: SecureInputCell.cellIdentifier)
        mainTableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.cellIdentifier)
        mainTableView.register(SegmentedCell.self, forCellReuseIdentifier: SegmentedCell.cellIdentifier)
        mainTableView.register(StateCell.self, forCellReuseIdentifier: StateCell.cellIdentifier)
        mainTableView.register(SwitcherCell.self, forCellReuseIdentifier: SwitcherCell.cellIdentifier)
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainTableView)
        mainTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        mainTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        mainTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    private func configureNewQuizzButton() {
        newQuizButton.title = "new"
        newQuizButton.target = self
        newQuizButton.action = #selector(newQuizButtonWasPressed)
        navigationItem.setRightBarButton(newQuizButton, animated: false)
    }
    
    
    // MARK: User Action
    
    @objc func newQuizButtonWasPressed() {
        router.routeToNewQuiz()
    }
    
    // MARK: Navigate
    
    func navigateToQuizzes(request: QuizzesModels.Request) {
        router.routeToQuizzes(request: request)
    }
    
    // MARK: Display
    
    func displayCategories(viewModel: FormModels.ViewModel) {
        mainViewModel = viewModel
        mainTableView.reloadData()
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return mainViewModel?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mainViewModel?.getSectionTitle(for: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewModel?.sections[section].entries.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return mainViewModel?.getCell(at: indexPath, for: tableView) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        mainViewModel?.onCellSelection(at: indexPath)
    }
}

