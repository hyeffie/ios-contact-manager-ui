//
//  ContactListDataSource.swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

import UIKit

enum ContactListSection {
    case contact
}

enum ContactListItem: Hashable {
    case contact(Contact)
}

final class ContactListDataSource: UITableViewDiffableDataSource<ContactListSection, ContactListItem> {
    typealias TableView = ContactListView
    typealias ContactCell = ContactListCell
    
    static let cellProvider: CellProvider = { tableview, indexPath, itemIdentifier in
        switch itemIdentifier {
        case .contact(let contact):
            guard let cell = tableview.dequeueReusableCell(
                withIdentifier: ContactCell.reuseIdentifier, for: indexPath
            ) as? ContactCell else { return UITableViewCell() }
            cell.update(with: contact)
            return cell
        }
    }
    
    convenience init(_ listView: TableView) {
        self.init(tableView: listView, cellProvider: Self.cellProvider)
    }
}
