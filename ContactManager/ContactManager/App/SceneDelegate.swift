//
//  SceneDelegate.swift
//  ContactManager
//
//  Created by Effie on 1/5/24.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    let tempContacts: [Contact] = [
        .init(name: "John Smith", phoneNumber: "123-456-7890", age: 25),
        .init(name: "Emily Johnson", phoneNumber: "234-567-8901", age: 30),
        .init(name: "Daniel Williams", phoneNumber: "345-678-9012", age: 22),
        .init(name: "Olivia Brown", phoneNumber: "456-789-0123", age: 35),
        .init(name: "James Jones", phoneNumber: "567-890-1234", age: 28),
        .init(name: "Sophia Davis", phoneNumber: "678-901-2345", age: 40),
        .init(name: "William Taylor", phoneNumber: "789-012-3456", age: 32),
        .init(name: "Emma Martinez", phoneNumber: "890-123-4567", age: 27),
        .init(name: "Liam Jackson", phoneNumber: "901-234-5678", age: 38),
        .init(name: "Ava White", phoneNumber: "012-345-6789", age: 31),
        .init(name: "Michael Anderson", phoneNumber: "123-456-7890", age: 29),
        .init(name: "Sophie Moore", phoneNumber: "234-567-8901", age: 33),
        .init(name: "Matthew Wilson", phoneNumber: "345-678-9012", age: 26),
        .init(name: "Ella Harris", phoneNumber: "456-789-0123", age: 36),
        .init(name: "Alexander Thompson", phoneNumber: "567-890-1234", age: 24),
        .init(name: "Grace Nelson", phoneNumber: "678-901-2345", age: 39),
        .init(name: "Christopher Hill", phoneNumber: "789-012-3456", age: 34),
        .init(name: "Sophie Rivera", phoneNumber: "890-123-4567", age: 37),
        .init(name: "Henry Scott", phoneNumber: "901-234-5678", age: 23),
        .init(name: "Chloe Hall", phoneNumber: "012-345-6789", age: 41),
        .init(name: "Jacob Adams", phoneNumber: "123-456-7890", age: 32),
        .init(name: "Lily Baker", phoneNumber: "234-567-8901", age: 28),
        .init(name: "Andrew Green", phoneNumber: "345-678-9012", age: 30),
        .init(name: "Mia Cooper", phoneNumber: "456-789-0123", age: 27),
        .init(name: "Benjamin Reed", phoneNumber: "567-890-1234", age: 35),
    ]
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let contactList = ContactList(contacts: tempContacts)
        let listContactUseCase = ListContactUseCase(contactList: contactList)
        window.rootViewController = ListContactViewController(useCase: listContactUseCase)
        window.makeKeyAndVisible()
        self.window = window
    }
}
