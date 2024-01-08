//
//  ContactListView.swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

import UIKit

final class ContactListView: UITableView {
    typealias ContactCell = ContactListCell
    typealias DataSource = ContactListDataSource
    
    private lazy var contactListDataSource: DataSource = .init(
        tableView: self,
        cellProvider: DataSource.cellProvider
    )
    
    convenience init() {
        self.init(frame: .zero, style: .plain)
        setCollection()
    }
    
    private func setCollection() {
        register(ContactCell.self, forCellReuseIdentifier: ContactCell.reuseIdentifier)
    }
    
    func update(with contact: [Contact]) {
        self.contactListDataSource.update(with: contact)
    }
}
