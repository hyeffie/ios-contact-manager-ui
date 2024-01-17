//
//  AddContactViewController.swift
//  ContactManager
//
//  Created by Effie on 1/13/24.
//

import UIKit

final class AddContactViewController: UIViewController {
    private var addContactUseCase: AddContactUseCase
    
    private weak var coordinator: AddContactViewControllerDelegate?
    
    private let nameField = InputView(fieldName: "이름", keyboardType: .default, formatter: NameFormatter())
    
    private let ageField = InputView(fieldName: "나이", keyboardType: .numberPad, formatter: AgeFormatter())
    
    private let phoneNumberField = InputView(fieldName: "전화번호", keyboardType: .phonePad, formatter: PhoneNumberFormatter())
    
    private lazy var fieldStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(self.nameField)
        stack.addArrangedSubview(self.ageField)
        stack.addArrangedSubview(self.phoneNumberField)
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var saveButton: UIBarButtonItem = {
        let action = UIAction { [weak self] _ in self?.save() }
        let button = UIBarButtonItem(systemItem: .save, primaryAction: action)
        return button
    }()
    
    private lazy var cancelButton: UIBarButtonItem = {
        let action = UIAction { [weak self] _ in self?.cancel() }
        let button = UIBarButtonItem(systemItem: .cancel, primaryAction: action)
        return button
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(
        useCase: AddContactUseCase,
        coordinator: AddContactViewControllerDelegate
    ) {
        self.addContactUseCase = useCase
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        self.addContactUseCase.presenter = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func save() {
        let request = AddContact.Request(
            name: self.nameField.currentValue,
            age: self.ageField.currentValue,
            phoneNumber: self.phoneNumberField.currentValue
        )
        self.addContactUseCase.saveNewContact(request: request)
    }
    
    private func cancel() {
        let request = AddContact.Request(
            name: self.nameField.currentValue,
            age: self.ageField.currentValue,
            phoneNumber: self.phoneNumberField.currentValue
        )
        self.addContactUseCase.confirmCancel(request: request)
    }
    
    private static let title = "새 연락처"
    
    private func setupViews() {
        self.view.backgroundColor = .systemBackground
        self.title = Self.title
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = saveButton
        
        self.view.addSubview(fieldStack)
        NSLayoutConstraint.activate([
            fieldStack.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12),
            fieldStack.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            fieldStack.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}

extension AddContactViewController: AddContactPresentable {
    func presentAddContact(result: Result<Void, Error>) {
        switch result {
        case .success:
            self.coordinator?.endAddContact()
        case .failure(let error):
            handleError(error)
        }
    }
    
    func presentCancelConfirmation(result: Result<Void, Error>) {
        switch result {
        case .success:
            self.coordinator?.cancelAddContact()
        case .failure(let error):
            if let addContactError = error as? AddContactError,
               addContactError == .someFieldIsFilled {
                let cancelAction = UIAlertAction(title: "작성 취소", style: .default) { _ in
                    self.coordinator?.endAddContact()
                }
                self.presentErrorAlert(error: addContactError, additionalAction: cancelAction)
            }
        }
    }
    
    private func handleError(_ error: Error) {
        if let error = error as? LocalizedError {
            print(error.localizedDescription)
        }
        if let error = error as? AlertableError {
            showErrorAlert(error: error)
        }
    }
}

extension AddContactViewController: ErrorAlertPresentableViewController {
    private func showErrorAlert(error: AlertableError) {
        self.presentErrorAlert(error: error)
    }
}
