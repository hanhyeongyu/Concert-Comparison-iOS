//
//  File.swift
//  
//
//  Created by 한현규 on 7/26/24.
//

import Foundation
import SwiftUI


extension AppStorage {
    public init(wrappedValue: Value, _ key: PreferenceStorage.Key<Value>) where Value == String {
        self.init(wrappedValue: wrappedValue, key.name, store: PreferenceStorage.shared.userDefaults)
    }
    
    public init(wrappedValue: Value, _ key: PreferenceStorage.Key<Value>) where Value == Bool {
        self.init(wrappedValue: wrappedValue, key.name, store: PreferenceStorage.shared.userDefaults)
    }
    
    public init(wrappedValue: Value, _ key: PreferenceStorage.Key<Value>) where Value == Int {
        self.init(wrappedValue: wrappedValue, key.name, store: PreferenceStorage.shared.userDefaults)
    }
}
