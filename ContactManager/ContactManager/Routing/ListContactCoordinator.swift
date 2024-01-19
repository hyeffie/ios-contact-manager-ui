//
//  ListContactCoordinator.swift
//  ContactManager
//
//  Created by Effie on 1/14/24.
//

import UIKit

final class ListContactCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let contactRepository: ContactRepository
    
    init(
        navigationController: UINavigationController,
        contactRepository: ContactRepository
    ) {
        self.navigationController = navigationController
        self.contactRepository = contactRepository
    }
    
    func start() {
        let viewController = ListContactViewController(
            listContactUseCase: ListContactUseCase(repository: contactRepository),
            searchContactUseCase: SearchContactUseCase(repository: contactRepository),
            coordinator: self
        )
        self.navigationController.viewControllers = [viewController]
    }
}

protocol ListContactViewControllerDelegate: AnyObject {
    func startAddContact()
}

extension ListContactCoordinator: ListContactViewControllerDelegate {
    func startAddContact() {
        let coordinator = AddContactCoordinator(
            navigationController: self.navigationController,
            contactRepository: self.contactRepository
        )
        coordinator.parentCoordinator = self
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
}

// MARK: - AddContactCoordinatorDelegate Implementation

protocol AddContactCoordinatorDelegate {
    func didEndAddContact(_ coordinator: AddContactCoordinator)
}

extension ListContactCoordinator: AddContactCoordinatorDelegate {
    func didEndAddContact(_ coordinator: AddContactCoordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
        handleListContactViewControllerVisibility()
    }
    
    private func handleListContactViewControllerVisibility() {
        if let viewController = self.navigationController.viewControllers.last as? ModalViewControllerDismissingHandlable {
            viewController.viewControllerWillAppear()
        }
    }
}

// MARK: - ModalViewControllerDismissingHandlable

protocol ModalViewControllerDismissingHandlable {
    func viewControllerWillAppear()
}
