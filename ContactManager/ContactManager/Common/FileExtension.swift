//
//  FileExtension.swift
//  ContactManager
//
//  Created by Effie on 1/8/24.
//

struct FileExtension: RawRepresentable {
    static let json = Self(rawValue: "json")

    let rawValue: String

    init(rawValue: String) {
       self.rawValue = rawValue
    }
}
