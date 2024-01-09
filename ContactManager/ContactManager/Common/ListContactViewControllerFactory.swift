//
//  ListContactViewControllerFactory.swift
//  ContactManager
//
//  Created by Effie on 1/7/24.
//

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
        return ContactRepositoryImpl()
    }
}
