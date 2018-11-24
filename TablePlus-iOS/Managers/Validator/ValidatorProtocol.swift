//
//  ValidatorProtocol.swift
//  TablePlus-iOS
//
//  Created by Son on 11/24/18.
//  Copyright © 2018 TablePlus. All rights reserved.
//

import UIKit

// MARK: - ValidationTriggerProtocol
protocol ValidationTriggerProtocol {
    @discardableResult
    func applyValidate(by validator: ValidatorProtocol) throws -> Bool
}
extension ValidationTriggerProtocol {
    /// LalaValidator: ValidationTriggerProtocol
    ///
    /// - Parameter value: A ValidatorProtocol which contains a set of conditions
    /// - Returns: isValidated or not
    @discardableResult
    func applyValidate(by validator: ValidatorProtocol) throws -> Bool {
        do {
            return try validator.isValidated(self)
        } catch { throw error }
    }
}
/// ValidationTriggerProtocols extensions
extension String: ValidationTriggerProtocol {}
extension NSObject: ValidationTriggerProtocol {}
extension Array: ValidationTriggerProtocol {}

// MARK: - ValidatorProtocol
protocol ValidatorProtocol {
    /// LalaValidator: Validator protocol.
    ///
    /// - Parameter value: Any object to check its validation.
    /// - Returns: Validator of this value.
    @discardableResult
    func isValidated(_ value: Any) throws -> Bool
}
