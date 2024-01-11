//
//  BundleResourceManager.swift
//  ContactManager
//
//  Created by Effie on 1/8/24.
//

import Foundation

protocol FileProvidable {
    func getData(from fileName: String, extension fileExtension: FileExtension) throws -> Data
}

struct BundleResourceManager {
    private let targetBundle: Bundle
    
    init(target: Bundle) {
        self.targetBundle = target
    }
}

extension BundleResourceManager: FileProvidable {
    func getData(from fileName: String, extension fileExtension: FileExtension) throws -> Data {
        let target = Bundle.main
        guard let url = target.url(
            forResource: fileName,
            withExtension: fileExtension.rawValue
        ) else {
            throw BundleResourceError.notFound
        }
        return try Data(contentsOf: url)
    }
}
