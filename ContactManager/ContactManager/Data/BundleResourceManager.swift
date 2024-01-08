//
//  BundleResourceManager.swift
//  ContactManager
//
//  Created by Effie on 1/8/24.
//

import Foundation

struct BundleResourceManager {
    func getData(from fileName: String, extension fileExtension: FileExtension) throws -> Data {
        let target = Bundle.main
        guard let url = target.url(
            forResource: fileName,
            withExtension: fileExtension.string
        ) else {
            throw BundleResourseError.notFound
        }
        return try Data(contentsOf: url)
    }
}
