//
//  StringExtension.swift
//  BAMXapp
//
//  Created by Manuel Ignacio Cota Casas on 01/10/21.
//

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
