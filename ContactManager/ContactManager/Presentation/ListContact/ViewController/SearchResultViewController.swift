//
//  SearchResultViewController.swift
//  ContactManager
//
//  Created by Effie on 1/19/24.
//

import UIKit

final class SearchResultViewController: UIViewController { 
    enum ListState {
        case noContacts
        case noSearchingResults
        case noProblem
    }
    
    private static let title = "연락처 검색"
    
    private let contactListView: ContactListTableView = {
        let tableView = ContactListTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var contactListDataSource: ContactListDataSource = ContactListDataSource(self.contactListView)
    
    private var searchController: UISearchController?
    
    private var listIsEmpty: ListState = .noProblem {
        didSet {
            setNeedsUpdateContentUnavailableConfiguration()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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

extension SearchResultViewController {
    private func setupViews() {
        self.title = Self.title
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
    }
}

extension SearchResultViewController: SearchContactPresentable {
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
