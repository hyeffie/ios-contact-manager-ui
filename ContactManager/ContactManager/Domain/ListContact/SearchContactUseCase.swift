//
//  SearchContactUseCase.swift
//  ContactManager
//
//  Created by Effie on 1/19/24.
//

struct SearchContactUseCase {
    private let repository: ContactRepository
    
    weak var presenter: SearchContactPresentable?
    
    init(repository: ContactRepository) {
        self.repository = repository
    }
    
    func searchContact(with query: String) {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        let queries = trimmedQuery.components(separatedBy: .whitespacesAndNewlines)
        do {
            let matchingContacts = try repository.searchContact(with: queries)
            let successInfo = ListContact.SuccessInfo(contacts: matchingContacts)
            presenter?.presentSearchContact(result: .success(successInfo))
        } catch {
            presenter?.presentSearchContact(result: .failure(error))
        }
    }
    
    func fetchAllContacts() {
        do {
            let contacts = try repository.requestContacts()
            let successInfo = ListContact.SuccessInfo(contacts: contacts)
            presenter?.presentListContact(result: .success(successInfo))
        } catch {
            presenter?.presentListContact(result: .failure(error))
        }
    }
}

import Foundation

protocol SearchContactPresentable: NSObjectProtocol {
    func presentListContact(result: Result<ListContact.SuccessInfo, Error>)
    func presentSearchContact(result: Result<ListContact.SuccessInfo, Error>)
}
