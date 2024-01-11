//
//  ErrorAlertConfig.swift
//  ContactManager
//
//  Created by Effie on 1/9/24.
//

struct ErrorAlertConfig {
    let title: String
    let body: String
    let okActionTitle: String
    
    init(title: String = "알림", body: String, okActionTitle: String = "확인") {
        self.title = title
        self.body = body
        self.okActionTitle = okActionTitle
    }
}
