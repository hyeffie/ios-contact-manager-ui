//
//  ListContactUseCase.swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

struct ListContactUseCase {
    private let contactList: ContactList
    
    weak var presenter: ListContactPresentable?
    
    init(contactList: ContactList) {
        self.contactList = contactList
    }
    
    func fetchAllContacts() {
        let contacts = contactList.getContacts()
        let result = ListContactModel.Result.SuccessInfo(contacts: contacts)
        presenter?.presentListContact(result: .success(result))
    }
}

import Foundation

protocol ListContactPresentable: NSObjectProtocol {
    func presentListContact(result: ListContactModel.Result)
}
