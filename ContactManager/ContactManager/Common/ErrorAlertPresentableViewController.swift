//
//  ErrorAlertPresentableViewController.swift
//  ContactManager
//
//  Created by Effie on 1/9/24.
//

import UIKit

typealias AlertActionHandler = ((UIAlertAction) -> Void)

protocol ErrorAlertPresentableViewController {
    func presentErrorAlert(
        error: AlertableError,
        additionalAction: UIAlertAction?
    )
}

extension ErrorAlertPresentableViewController where Self: UIViewController {
    func presentErrorAlert(
        error: AlertableError,
        additionalAction: UIAlertAction? = nil
    ) {
        let alertController = UIAlertController(
            title: error.alertConfig.title,
            message: error.alertConfig.body,
            preferredStyle: .alert
        )
        let defaultAction = UIAlertAction(title: "확인", style: .default)
        alertController.addAction(defaultAction)
        
        if let additionalAction {
            alertController.addAction(additionalAction)
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true)
        }
    }
}
