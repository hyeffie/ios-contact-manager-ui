//
//  ListContactViewControllerFactory.swift
//  ContactManager
//
//  Created by Effie on 1/7/24.
//

import Foundation

enum ListContactViewControllerFactory {
    static func make() -> ListContactViewController {
        let useCase = Self.makeUseCase()
        return ListContactViewController(useCase: useCase)
    }
    
    private static func makeUseCase() -> ListContactUseCase {
        let repository = Self.makeRepository()
        return ListContactUseCase(repository: repository)
    }
    
    private static func makeRepository() -> ContactRepository {
        let contactList = makeContactList()
        let fileProvider = makeFileProvider()
        return ContactRepositoryImpl(contactList: contactList, fileProvider: fileProvider)
    }
    
    private static func makeFileProvider() -> FileProvidable {
        let targetBundle = Bundle.main
        return BundleResourceManager(target: targetBundle)
    }
    
    private static func makeContactList() -> ContactList {
        return ContactList()
    }
}
