//
//  ListContactModel.swift
//  ContactManager
//
//  Created by Effie on 1/6/24.
//

struct ListContactModel {
    enum Result {
        struct SuccessInfo {
            var contacts: [Contact]
        }
        
        case success(SuccessInfo)
        case fail
    }
}
