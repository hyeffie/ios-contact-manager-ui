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
        do {
            let contacts = try repository.requestContacts()
            let result = ListContactModel.Result.SuccessInfo(contacts: contacts)
            presenter?.presentListContact(result: .success(result))
        } catch {
            presenter?.presentListContact(result: .fail(error))
        }
    }
}

import Foundation

protocol ListContactPresentable: NSObjectProtocol {
    func presentListContact(result: ListContactModel.Result)
}
