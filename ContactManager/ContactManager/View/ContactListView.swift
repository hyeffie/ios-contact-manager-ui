//
//  ContactListView.swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

import UIKit

final class ContactListView: UITableView {
    typealias ContactCell = ContactListCell
    
    convenience init() {
        self.init(frame: .zero, style: .plain)
        setCollection()
    }
    
    private func setCollection() {
        register(ContactCell.self, forCellReuseIdentifier: ContactCell.reuseIdentifier)
    }
}
