//
//  ListContactViewController.swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

import UIKit

final class ListContactViewController: UIViewController {
    private let listContactUseCase: ListContactUseCase?
    
    private let contactListView: ContactListView = {
        let tableView = ContactListView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var contactListDataSource: ContactListDataSource = ContactListDataSource(self.contactListView)
    
    init(useCase: ListContactUseCase) {
        self.listContactUseCase = useCase
        super.init(nibName: nil, bundle: nil)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        self.listContactUseCase = nil
        super.init(coder: coder)
        setLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
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
