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
    private let targetBundle: Bundle
    
    private let jsonDecoder: JSONDecoder = .init()
    
    init(targetBundle: Bundle = Bundle.main) {
        self.targetBundle = targetBundle
    }
    
    func requestContacts() throws -> [Contact] {
        do {
            let data = try getContactsFromBundle()
            return try self.jsonDecoder.decode([Contact].self, from: data)
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
        return try BundleResourceManager(target: self.targetBundle).getData(from: fileName, extension: FileExtension.json)
    }
}
