//
//  ContactRepository.swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

import Foundation

protocol ContactRepository {
    func requestContacts() throws -> [Contact]
}

struct ContactRepositoryImpl: ContactRepository {
    private let contactList: ContactList
    
    private let fileProvider: FileProvidable
    
    private let jsonDecoder: JSONDecoder = .init()
    
    init(
        contactList: ContactList,
        fileProvider: FileProvidable
    ) {
        self.contactList = contactList
        self.fileProvider = fileProvider
    }
    
    func requestContacts() throws -> [Contact] {
        do {
            let data = try getContactsFromBundle()
            let contacts = try self.jsonDecoder.decode([Contact].self, from: data)
            self.contactList.addContacts(contacts)
            return self.contactList.getContacts()
        } catch BundleResourceError.notFound {
            throw ContactRepositoryError.notFoundAtBundle
        } catch {
            throw ContactRepositoryError.cannotDecode
        }
    }
}

extension ContactRepositoryImpl {
    private func getContactsFromBundle() throws -> Data {
        let fileName = "contacts"
        return try fileProvider.getData(from: fileName, extension: FileExtension.json)
    }
}

