//
//  FormViewController.swift
//  GoGo
//
//  Created by Mathias Erligmann on 23/11/2020.
//

import UIKit

class FormViewController: UIViewController {
    
    private let formTableView = UITableView(frame: .zero, style: .insetGrouped)
    private let closeButton = UIBarButtonItem()
    private let actionButton = UIBarButtonItem()
    
    var request: FormModels.Request?
    
    private var formViewModel: FormModels.ViewModel?
    
    var interactor: FormInteractor?
    var router: FormRouter?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureBackground()
        configureActionButton()
        configureTableView()
        
        interactor?.loadForm()
    }
    
    // MARK: Setup
    
    func setup() {
        router = FormRouter()
        router?.viewController = self
        interactor = FormInteractor()
        interactor?.request = request
        interactor?.presenter.viewController = self
    }
    
    // MARK: Configure
    
    private func configureBackground() {
        view.backgroundColor = .systemRed
    }
    
    private func configureActionButton() {
        actionButton.target = self
        actionButton.action = #selector(saveButtonWasPressed)
        actionButton.isEnabled = false
        navigationItem.setRightBarButton(actionButton, animated: false)
    }
    
    private func configureTableView() {
        formTableView.delegate = self
        formTableView.dataSource = self
        formTableView.rowHeight = 50
        formTableView.register(BasicCell.self, forCellReuseIdentifier: BasicCell.cellIdentifier)
        formTableView.register(TextCell.self, forCellReuseIdentifier: TextCell.cellIdentifier)
        formTableView.register(TextInputCell.self, forCellReuseIdentifier: TextInputCell.cellIdentifier)
        formTableView.register(SecureInputCell.self, forCellReuseIdentifier: SecureInputCell.cellIdentifier)
        formTableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.cellIdentifier)
        formTableView.register(SegmentedCell.self, forCellReuseIdentifier: SegmentedCell.cellIdentifier)
        formTableView.register(StateCell.self, forCellReuseIdentifier: StateCell.cellIdentifier)
        formTableView.register(SwitcherCell.self, forCellReuseIdentifier: SwitcherCell.cellIdentifier)
        formTableView.register(ResultCell.self, forCellReuseIdentifier: ResultCell.cellIdentifier)
        formTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(formTableView)
        formTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        formTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        formTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        formTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    // MARK: User Action
    
    @objc private func closeButtonWasPressed() {
        interactor?.closeForm()
    }
    
    @objc private func saveButtonWasPressed() {
        interactor?.saveForm(formController: self)
    }
    
    // MARK: Navigate
    
    func navigateToPreviousViewController(completion: (() -> Void)?) {
        router?.routeToPreviousViewController(completion: completion)
    }
    
    // MARK: Display
    
    func displayCloseButton() {
        closeButton.title = "form_closeButton_title".localized()
        closeButton.target = self
        closeButton.action = #selector(closeButtonWasPressed)
        navigationItem.setLeftBarButton(closeButton, animated: false)
    }
    
    func displayTitle(title: String) {
        self.title = title
    }
    
    func displayActionButtonTitle(title: String?) {
        actionButton.title = title?.localized()
    }
    
    func displayActionButtonState(enabled: Bool) {
        actionButton.isEnabled = enabled
    }
    
    func displayForm(viewModel: FormModels.ViewModel) {
        self.formViewModel = viewModel
        formTableView.reloadData()
    }
}

extension FormViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return formViewModel?.sections.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return formViewModel?.getSectionTitle(for: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formViewModel?.sections[section].entries.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return formViewModel?.getCell(at: indexPath, for: tableView) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        formViewModel?.onCellSelection(at: indexPath)
    }
}
