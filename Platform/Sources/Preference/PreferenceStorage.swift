//
//  PreferenceStorage.swift
//  WelcomeKorea
//
//  Created by 한현규 on 2023/02/01.
//

import Foundation
import LogUtil

private let defaultSuiteName = "kata.practice.shared_suite"

/**
 PreferenceStorage에 저장된 값에 접근하기 위한 기본 키를 정의하는 클래스
 
 타 모듈에서는 아래와 같은 형태로 프로퍼티를 추가할 수 있음
 ```
 public extension PrefKeyDefinition {
 var boolProperty: PrefKey<Bool> {
 return .init(name: "SHOWS_TURORIAL", defaultValue: true)
 }
 }
 ```
 */
public final class PreferenceKeys {
    public typealias PrefKey = PreferenceStorage.Key
}

/// Storage class to save key-value data to UserDefaults or Keychain, with type check on compile time.
/// UserDefaults 혹은 Keychain에 키-값 쌍을 저장하기 위한 클래스
@dynamicMemberLookup
public final class PreferenceStorage {
    public struct Key<Value> {
        public let name: String
        public let defaultValue: Value
        public let encrypted: Bool
        
        public init(name: String, defaultValue: Value, encrypted: Bool) {
            self.name = name
            self.defaultValue = defaultValue
            self.encrypted = encrypted
        }
    }
    
    public static let shared = PreferenceStorage(suiteName: defaultSuiteName, serviceName: defaultKeychainService)
    
    private let suiteName: String
    private let keychainServiceName: String
    public let prefKeys = PreferenceKeys()
    
    public lazy var userDefaults = UserDefaults(suiteName: suiteName)!

    private lazy var keychainAccess = KeychainAccess(serviceName: keychainServiceName)
    
    init(suiteName: String, serviceName: String) {
        self.suiteName = suiteName
        self.keychainServiceName = serviceName
    }
    
    public subscript(dynamicMember keyPath: KeyPath<PreferenceKeys, Key<String>>) -> String {
        get {
            let key = prefKeys[keyPath: keyPath]
            if key.encrypted {
                return keychainAccess.get(forAccountKey: key.name) ?? key.defaultValue
            } else {
                return userDefaults.string(forKey: key.name) ?? key.defaultValue
            }
        }
        set {
            let key = prefKeys[keyPath: keyPath]
            if key.encrypted {
                do {
                    try keychainAccess.set(newValue, forAccountKey: key.name)
                } catch {
                    Log.e(error.localizedDescription)
                    return
                }
            } else {
                userDefaults.set(newValue, forKey: key.name)
            }
            Log.v("Saved to PreferenceStorage: \(key.name) <- \(newValue)")
        }
    }
    
    
    
    public subscript(dynamicMember keyPath: KeyPath<PreferenceKeys, Key<[String]>>) -> [String] {
        get {
            let key = prefKeys[keyPath: keyPath]
            return userDefaults.stringArray(forKey: key.name) ?? key.defaultValue
        }
        set {
            let key = prefKeys[keyPath: keyPath]
            userDefaults.set(newValue, forKey: key.name)
            Log.v("Saved to PreferenceStorage: \(key.name) <- \(newValue)")
        }
    }
    
    public subscript(dynamicMember keyPath: KeyPath<PreferenceKeys, Key<Bool>>) -> Bool {
        get {
            let key = prefKeys[keyPath: keyPath]
            return userDefaults.bool(forKey: key.name)
        }
        set {
            let key = prefKeys[keyPath: keyPath]
            userDefaults.set(newValue, forKey: key.name)
            Log.v("Saved to PreferenceStorage: \(key.name) <- \(newValue)")
        }
    }
    
    public subscript<Value>(dynamicMember keyPath: KeyPath<PreferenceKeys, Key<Value>>) -> Value {
        get {
            let key = prefKeys[keyPath: keyPath]
            return userDefaults.object(forKey: key.name) as? Value ?? key.defaultValue
        }
        set {
            let key = prefKeys[keyPath: keyPath]
            userDefaults.set(newValue, forKey: key.name)
            Log.v("Saved to PreferenceStorage: \(key.name) <- \(newValue)")
        }
    }
    
    
    public subscript<Value : Codable>(dynamicMember keyPath: KeyPath<PreferenceKeys, Key<Value>>) -> Value {
        get {
            let key = prefKeys[keyPath: keyPath]
            guard let data = userDefaults.object(forKey: key.name) as? Data else { return key.defaultValue}
            let decode =  try? JSONDecoder().decode(Value.self, from: data)
            return decode ?? key.defaultValue
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                let key = prefKeys[keyPath: keyPath]
                userDefaults.set(encoded, forKey: key.name)
                Log.v("Saved to PreferenceStorage: \(key.name) <- \(newValue)")
            }
        }
    }
    
    /// key 와 연결된 값을 제거
    public func remove<Value: Any>(forKey key: Key<Value>) {
        if key.encrypted {
            do {
                try keychainAccess.removeValue(forAccountKey: key.name)
            } catch {
                Log.e(error.localizedDescription)
            }
        } else {
            userDefaults.removeObject(forKey: key.name)
        }
    }
    
    
    public func clearAll() {
        UserDefaults.standard.removePersistentDomain(forName: suiteName)
        do {
            try keychainAccess.removeAll()
        } catch {
            Log.e(error.localizedDescription)
        }
    }
}

public extension PreferenceStorage.Key {
    init(name: String, defaultValue: Value) {
        self.init(name: name, defaultValue: defaultValue, encrypted: false)
    }
}

public extension PreferenceStorage.Key where Value == Bool {
    init(name: String) {
        self.init(name: name, defaultValue: false)
    }
}

public extension PreferenceStorage.Key where Value: ExpressibleByIntegerLiteral {
    init(name: String) {
        self.init(name: name, defaultValue: 0)
    }
}

public extension PreferenceStorage.Key where Value == String {
    init(name: String) {
        self.init(name: name, defaultValue: "")
    }
}
