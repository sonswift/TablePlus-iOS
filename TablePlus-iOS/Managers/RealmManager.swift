//
//  RealmManager.swift
//  TablePlus-iOS
//
//  Created by Son on 11/24/18.
//  Copyright © 2018 TablePlus. All rights reserved.
//

import UIKit
import RealmSwift

/// LalaManager: Manager Saving protocol.
protocol ManagerSavingProtocol {
    func save<T: Object>(_ object: T, update: Bool) throws
    func save<T: Object>(_ objects: [T], update: Bool) throws
}
/// LalaManager: Manager Getting protocol.
protocol ManagerGettingProtocol {
    func object<T: Object>(with type: T.Type, key: Any) -> T?
    func objects<T: Object>(with type: T.Type) -> [T]
}
/// LalaManager: Manager Getting with Sort protocol.
protocol ManagerGettingSortedProtocol {
    func objects<T: Object>(with type: T.Type, sortKeypath: String, ascending: Bool) -> [T]
}
/// LalaManager: Manager Update protocol.
protocol ManagerUpdateProtocol {
    func update(block: @escaping () -> Void) throws
}
/// LalaManager: Manager Delete protocol.
protocol ManagerDeleteProtocol {
    func delete<T: Object>(object: T) throws
    func delete<T: Object>(objects: [T]) throws
}

// MARK: - Realms
protocol RealmProtocol {
    var realm: Realm? { get }
    var memoryRealm: Realm? { get }
}

class RealmManager: RealmProtocol {
    struct Config {
        static let memoryIdentifer = "MemoryRealm"
    }
    private var isMemorySaved = true
    private var validator: ValidatorProtocol?
    internal var realm = try? Realm()
    internal var memoryRealm = try? Realm(configuration: Realm.Configuration(inMemoryIdentifier: Config.memoryIdentifer))

    init(inMemory: Bool) {
        self.isMemorySaved = inMemory
    }
    convenience init(inMemory: Bool, validator: ValidatorProtocol) {
        self.init(inMemory: inMemory)
        self.validator = validator
    }
    internal func getRealm() -> Realm? {
        return isMemorySaved ? memoryRealm : realm
    }
    internal func getValidator() -> ValidatorProtocol? {
        return validator
    }
}

// MARK: - Public static methods
extension RealmManager {
    static let classInit: Void = {
    }()
}

// MARK: - ManagerSavingProtocol
extension RealmManager: ManagerSavingProtocol {
    func save<T>(_ object: T, update: Bool) throws where T : Object {
        guard let _realm = getRealm() else { return }
        do {
            try _realm.write {
                _realm.add(object, update: update)
            }
        } catch { throw error }
    }

    func save<T>(_ objects: [T], update: Bool) throws where T : Object {
        guard let _realm = getRealm() else { return }
        do {
            try _realm.write {
                _realm.add(objects, update: update)
            }
        } catch { throw error }
    }
}

// MARK: - ManagerGettingProtocol
extension RealmManager: ManagerGettingProtocol {
    func object<T>(with type: T.Type, key: Any) -> T? where T : Object {
        guard let _realm = getRealm() else {
            return nil
        }
        return _realm.object(ofType: type, forPrimaryKey: key)
    }

    func objects<T>(with type: T.Type) -> [T] where T : Object {
        guard let _realm = getRealm() else {
            return []
        }
        return Array(_realm.objects(type))
    }
}

// MARK: - ManagerGettingSortedProtocol
extension RealmManager: ManagerGettingSortedProtocol {
    func objects<T>(with type: T.Type, sortKeypath: String, ascending: Bool) -> [T] where T : Object {
        guard let _realm = getRealm() else {
            return []
        }
        return Array(_realm.objects(type).sorted(byKeyPath: sortKeypath, ascending: ascending))
    }
}

// MARK: - ManagerUpdateProtocol
extension RealmManager: ManagerUpdateProtocol {
    func update(block: @escaping () -> Void) throws {
        guard let _realm = getRealm() else { return }
        do {
            try _realm.write {
                block()
            }
        } catch { throw error }
    }
}

// MARK: - ManagerDeleteProtocol
extension RealmManager: ManagerDeleteProtocol {
    func delete<T>(object: T) throws where T : Object {
        guard let _realm = getRealm() else { return }
        do {
            try _realm.write {
                _realm.delete(object)
            }
        } catch { throw error }
    }
    func delete<T>(objects: [T]) throws where T : Object {
        guard let _realm = getRealm() else { return }
        do {
            try _realm.write {
                _realm.delete(objects)
            }
        } catch { throw error }
    }
}

// MARK: - ManagerValidation
extension RealmManager: ValidatorProtocol {
    func isValidated(_ value: Any) throws -> Bool {
        do {
            return try getValidator()?.isValidated(value) ?? false
        } catch { throw error }
    }
}
