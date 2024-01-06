//
//  ListContactViewController.swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

import UIKit

final class ListContactViewController: UIViewController {
    private var listContactUseCase: ListContactUseCase?
    
    private let contactListView: ContactListView = {
        let tableView = ContactListView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var contactListDataSource: ContactListDataSource = ContactListDataSource(self.contactListView)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(useCase: ListContactUseCase) {
        self.listContactUseCase = useCase
        super.init(nibName: nil, bundle: nil)
        self.listContactUseCase?.presenter = self
        setLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        self.listContactUseCase?.fetchAllContacts()
    }
}

extension ListContactViewController {
    private func setLayout() {
        self.view.addSubview(contactListView)
        NSLayoutConstraint.activate([
            contactListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contactListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contactListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contactListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension ListContactViewController: ListContactPresentable {
    func presentListContact(result: ListContactModel.Result) {
        var snapshot = ContactListSnapShot()
        snapshot.appendSections([.contact])
        switch result {
        case .success(let successInfo):
            let contacts = successInfo.contacts.map { contact in ContactListItem.contact(contact) }
            snapshot.appendItems(contacts, toSection: .contact)
        case .fail:
            break
        }
        self.contactListDataSource.apply(snapshot)
    }
}
