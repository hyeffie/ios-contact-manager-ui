//
//  ContactListTableView .swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

import UIKit

final class ContactListTableView: UITableView {
    typealias ContactCell = ContactListCell
    typealias DataSource = ContactListDataSource
    
    convenience init() {
        self.init(frame: .zero, style: .plain)
        setCollection()
    }
    
    private func setCollection() {
        register(ContactCell.self)
    }
}
