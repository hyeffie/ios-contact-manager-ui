//
//  FileExtension.swift
//  ContactManager
//
//  Created by Effie on 1/8/24.
//

enum FileExtension {
    case json
    
    var string: String {
        switch self {
        case .json: return "json"
        }
    }
}
