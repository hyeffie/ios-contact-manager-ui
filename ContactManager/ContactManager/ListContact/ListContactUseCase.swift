//
//  ListContactUseCase.swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

struct ListContactUseCase {
    private let repository: ContactRepository
    
    weak var presenter: ListContactPresentable?
    
    init(repository: ContactRepository) {
        self.repository = repository
    }
    
    func fetchAllContacts() {
        let contacts = repository.requestContacts()
        let result = ListContactModel.Result.SuccessInfo(contacts: contacts)
        presenter?.presentListContact(result: .success(result))
    }
}

import Foundation

protocol ListContactPresentable: NSObjectProtocol {
    func presentListContact(result: ListContactModel.Result)
}
