//
//  PreferenceKeys+Auth.swift
//  
//
//  Created by 한현규 on 7/29/24.
//

import Foundation
import Preference

extension PreferenceKeys{
    var token : PrefKey<OAuthToken?>{ .init(name: "kToken", defaultValue: nil)}
}
