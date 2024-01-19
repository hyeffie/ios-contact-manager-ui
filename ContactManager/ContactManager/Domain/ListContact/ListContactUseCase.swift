//
//  ListContactUseCase.swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

struct ListContactUseCase {
    private let repository: ContactRepository
    
    weak var listContactPresenter: ListContactPresentable?
    
    weak var searchContactPresenter: SearchContactPresentable?
    
    init(repository: ContactRepository) {
        self.repository = repository
    }
    
    func fetchAllContacts() {
        do {
            let contacts = try repository.requestContacts()
            let successInfo = ListContact.SuccessInfo(contacts: contacts)
            listContactPresenter?.presentListContact(result: .success(successInfo))
        } catch {
            listContactPresenter?.presentListContact(result: .failure(error))
        }
    }
    
    func deleteContact(at index: Int) {
        do {
            try repository.removeContact(at: index)
            listContactPresenter?.presentDeleteContact(result: .success(()))
        } catch {
            listContactPresenter?.presentDeleteContact(result: .failure(error))
        }
    }
    
    func searchContact(with query: String) {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        let queries = trimmedQuery.components(separatedBy: .whitespacesAndNewlines)
        do {
            let matchingContacts = try repository.searchContact(with: queries)
            let successInfo = ListContact.SuccessInfo(contacts: matchingContacts)
            searchContactPresenter?.presentSearchContact(result: .success(successInfo))
        } catch {
            searchContactPresenter?.presentSearchContact(result: .failure(error))
        }
    }
}

import Foundation

protocol ListContactPresentable: NSObjectProtocol {
    func presentListContact(result: Result<ListContact.SuccessInfo, Error>)
    func presentDeleteContact(result: Result<Void, Error>)
}

protocol SearchContactPresentable: NSObjectProtocol {
    func presentSearchContact(result: Result<ListContact.SuccessInfo, Error>)
}
