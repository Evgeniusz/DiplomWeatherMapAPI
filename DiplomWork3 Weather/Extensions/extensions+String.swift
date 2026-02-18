//
//  extensions+String.swift
//  DiplomWork3 Weather
//
//  Created by Apple on 18.02.26.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
