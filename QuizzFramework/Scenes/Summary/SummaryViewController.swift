//
//  SummaryViewController.swift
//  QuizzFramework
//
//  Created by Mathias Erligmann on 25/12/2020.
//

import UIKit

class SummaryViewController: UIViewController {

    private let summaryTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var request: SummaryModels.Request?
    
    private var summaryViewModel: FormModels.ViewModel?
    
    private let interactor = SummaryInteractor()
    private let router = SummaryRouter()
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureBackground()
        configureTitle()
        configureSummaryTableView()
        
        interactor.loadSummary()
    }
    
    // MARK: Setup
    
    private func setup() {
        router.viewController = self
        interactor.presenter.viewController = self
        interactor.request = request
    }
    
    // MARK: Configure
    
    private func configureBackground() {
        view.backgroundColor = .primaryColor
    }
    
    private func configureTitle() {
        title = "Summary"
    }
    
    private func configureSummaryTableView() {
        summaryTableView.delegate = self
        summaryTableView.dataSource = self
        summaryTableView.rowHeight = 50
        summaryTableView.register(BasicCell.self, forCellReuseIdentifier: BasicCell.cellIdentifier)
        summaryTableView.register(TextCell.self, forCellReuseIdentifier: TextCell.cellIdentifier)
        summaryTableView.register(TextInputCell.self, forCellReuseIdentifier: TextInputCell.cellIdentifier)
        summaryTableView.register(SecureInputCell.self, forCellReuseIdentifier: SecureInputCell.cellIdentifier)
        summaryTableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.cellIdentifier)
        summaryTableView.register(SegmentedCell.self, forCellReuseIdentifier: SegmentedCell.cellIdentifier)
        summaryTableView.register(StateCell.self, forCellReuseIdentifier: StateCell.cellIdentifier)
        summaryTableView.register(SwitcherCell.self, forCellReuseIdentifier: SwitcherCell.cellIdentifier)
        summaryTableView.register(ResultCell.self, forCellReuseIdentifier: ResultCell.cellIdentifier)
        summaryTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(summaryTableView)
        summaryTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        summaryTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        summaryTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        summaryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    // MARK: Display
    
    func displaySummary(viewModel: FormModels.ViewModel) {
        summaryViewModel = viewModel
        summaryTableView.reloadData()
    }
    
    // MARK: Navigate
    
    func navigateToCorrection(request: QuestionsModels.Request) {
        router.routeToCorrection(request: request)
    }
}

extension SummaryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return summaryViewModel?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return summaryViewModel?.getSectionTitle(for: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return summaryViewModel?.sections[section].entries.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return summaryViewModel?.getCell(at: indexPath, for: tableView) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        summaryViewModel?.onCellSelection(at: indexPath)
    }
}
