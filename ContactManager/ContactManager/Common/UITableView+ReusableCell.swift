//
//  UITableView+ReusableCell.swift
//  ContactManager
//
//  Created by Effie on 1/9/24.
//

import UIKit

extension UITableView {
    func register<Cell: ReusableCell & AnyObject>(_ cellType: Cell.Type) {
        register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
}
