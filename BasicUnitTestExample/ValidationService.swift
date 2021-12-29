//
//  ValidationService.swift
//  BasicUnitTestExample
//
//  Created by Joe Wang on 29/12/21.
//

import Foundation

enum ValidationError: LocalizedError {
    case invalidValue
    case usernameTooLong
    case usernameTooShort
    case passwordTooLong
    case passwordTooShort

    var errorDescription: String? {
        switch self {
        case .invalidValue:
            return NSLocalizedString("invalid value", comment: "")
        case .usernameTooLong:
            return NSLocalizedString("Username too long.", comment: "")
        case .usernameTooShort:
            return NSLocalizedString("Username too short.", comment: "")
        case .passwordTooLong:
            return NSLocalizedString("Password too long.", comment: "")
        case .passwordTooShort:
            return NSLocalizedString("Password too short.", comment: "")
        }
    }
}


struct ValidationService {
    func validateUsername(_ username: String?) throws -> String {
        guard let username = username else { throw ValidationError.invalidValue }
        guard username.count > 3 else { throw ValidationError.usernameTooShort }
        guard username.count < 20 else { throw ValidationError.usernameTooLong }
        return username
    }

    func validatePassword(_ password: String?) throws -> String {
        guard let password = password else { throw ValidationError.invalidValue }
        guard password.count > 3 else { throw ValidationError.passwordTooShort }
        guard password.count < 20 else { throw ValidationError.passwordTooLong }
        return password
    }
}
