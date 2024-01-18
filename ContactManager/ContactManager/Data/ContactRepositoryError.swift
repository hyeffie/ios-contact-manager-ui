//
//  ContactRepositoryError.swift
//  ContactManager
//
//  Created by Effie on 1/8/24.
//

import Foundation

enum ContactRepositoryError: LocalizedError {
    case notFoundAtBundle
    case cannotDecode
    
    case cannotRemove
    
    var errorDescription: String? {
        var description: String = "\(String(describing: Self.self)).\(String(describing: self)): "
        switch self {
        case .notFoundAtBundle:
            description += "요청된 파일을 번들에서 찾을 수 없음"
        case .cannotDecode:
            description += "요청된 타입으로 디코딩 실패"
        case .cannotRemove:
            description += "인덱스 문제로 삭제 실패"
        }
        return description
    }
}

extension ContactRepositoryError: AlertableError {
    var alertConfig: ErrorAlertConfig {
        switch self {
        case .notFoundAtBundle:
            return .init(body: "표시할 연락처가 없어요.")
        case .cannotDecode:
            return .init(body: "데이터를 알맞은 형태로 바꿔줄 수 없어요.")
        case .cannotRemove:
            return .init(body: "선택한 연락처를 삭제할 수 없어요.")
        }
    }
}
