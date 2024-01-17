//
//  AddContactModel.swift
//  ContactManager
//
//  Created by Effie on 1/15/24.
//

enum AddContact {
    struct Request {
        let name: String
        let age: String
        let phoneNumber: String
        
        var isEmpty: Bool {
            return name.isEmpty && age.isEmpty && phoneNumber.isEmpty
        }
    }
}
