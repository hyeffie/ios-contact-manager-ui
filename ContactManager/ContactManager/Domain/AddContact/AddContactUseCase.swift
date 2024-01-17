//
//  AddContactUseCase.swift
//  ContactManager
//
//  Created by Effie on 1/14/24.
//

struct AddContactUseCase {
    private let repository: ContactRepository
    
    private let factory: ContactMakable
    
    weak var presenter: AddContactPresentable?
    
    init(
        repository: ContactRepository,
        factory: ContactMakable
    ) {
        self.repository = repository
        self.factory = factory
    }
    
    func saveNewContact(request: AddContact.Request) {
        do {
            let contact = try factory.makeContact(from: request)
            try repository.addContact(contact)
            presenter?.presentAddContact(result: .success(()))
        } catch {
            presenter?.presentAddContact(result: .failure(error))
        }
    }
    
    func confirmCancel(request: AddContact.Request) {
        do {
            guard request.isEmpty else { throw AddContactError.someFieldIsFilled }
            presenter?.presentCancelConfirmation(result: .success(()))
        } catch {
            presenter?.presentCancelConfirmation(result: .failure(error))
        }
    }
}

import Foundation

protocol AddContactPresentable: NSObjectProtocol {
    func presentAddContact(result: Result<Void, Error>)
    func presentCancelConfirmation(result: Result<Void, Error>)
}
