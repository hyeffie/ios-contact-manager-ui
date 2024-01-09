//
//  ReusableCell.swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
