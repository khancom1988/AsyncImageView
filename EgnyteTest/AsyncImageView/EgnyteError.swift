//
//  EgnyteError.swift
//  EgnyteTest
//
//  Created by Aadil Majeed on 01/10/22.
//

import Foundation

enum EgnyteError: Error {
    case generic(String)
}

extension EgnyteError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .generic(let message):
            return NSLocalizedString(
                message,
                comment: ""
            )
        }
    }
}
