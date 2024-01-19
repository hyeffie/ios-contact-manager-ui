//
//  SearchContactResultViewController.swift
//  ContactManager
//
//  Created by Effie on 1/19/24.
//

import UIKit

final class SearchContactResultViewController: UIViewController {
    private enum ListState {
        case noContacts
        case noSearchingResults
        case noProblem
    }
    
    private var searchContactUseCase: SearchContactUseCase?
    
    private let contactListView: ContactListTableView = {
        let tableView = ContactListTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var contactListDataSource: ContactListDataSource = ContactListDataSource(self.contactListView)
    
    private var listIsEmpty: ListState = .noProblem {
        didSet {
            setNeedsUpdateContentUnavailableConfiguration()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(useCase: SearchContactUseCase) {
        self.searchContactUseCase = useCase
        super.init(nibName: nil, bundle: nil)
        self.searchContactUseCase?.presenter = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.searchContactUseCase?.fetchAllContacts()
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            switch self.listIsEmpty {
            case .noContacts:
                self.contentUnavailableConfiguration = ContactUnavailableConfiguration.noContacts
            case .noSearchingResults:
                self.contentUnavailableConfiguration = ContactUnavailableConfiguration.noSearchingResults
            case .noProblem:
                self.contentUnavailableConfiguration = nil
            }
        }
    }
}

extension SearchContactResultViewController {
    private func setupViews() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(contactListView)
        NSLayoutConstraint.activate([
            contactListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contactListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contactListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contactListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func handle(error: Error) {
        if let error = error as? LocalizedError {
            print(error.localizedDescription)
        }
        if let error = error as? AlertableError {
            showErrorAlert(error: error)
        }
    }
    
    private func apply(result: Result<ListContact.SuccessInfo, Error>) {
        
    }
}

extension SearchContactResultViewController: SearchContactPresentable {
    func presentListContact(result: Result<ListContact.SuccessInfo, Error>) {
        var snapshot = ContactListSnapShot()
        snapshot.appendSections([.contact])
        switch result {
        case .success(let successInfo):
            self.listIsEmpty = .noProblem
            let contacts = successInfo.contacts.map(ContactListItem.contact)
            snapshot.appendItems(contacts, toSection: .contact)
        case .failure(let error):
            self.listIsEmpty = .noContacts
            handle(error: error)
        }
        self.contactListDataSource.apply(snapshot)
    }
    
    func presentSearchContact(result: Result<ListContact.SuccessInfo, Error>) {
        var snapshot = ContactListSnapShot()
        snapshot.appendSections([.contact])
        switch result {
        case .success(let successInfo):
            self.listIsEmpty = .noProblem
            let contacts = successInfo.contacts.map(ContactListItem.contact)
            snapshot.appendItems(contacts, toSection: .contact)
        case .failure(let error):
            self.listIsEmpty = .noSearchingResults
            handle(error: error)
        }
        self.contactListDataSource.apply(snapshot)
    }
}

extension SearchContactResultViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              query.isEmpty == false else {
            self.searchContactUseCase?.fetchAllContacts()
            return
        }
        self.searchContactUseCase?.searchContact(with: query)
    }
}

extension SearchContactResultViewController: ErrorAlertPresentableViewController {
    private func showErrorAlert(error: AlertableError) {
        switch error {
        default:
            return
        }
    }
}
