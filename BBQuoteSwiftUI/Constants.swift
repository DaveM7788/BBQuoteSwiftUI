//
//  Constants.swift
//  BBQuoteSwiftUI
//
//  Created by David McDermott on 9/9/23.
//

import Foundation

enum Constants {
    static let bbName = "Breaking Bad"
    static let bCSName = "Better Call Saul"
}

extension String {
    var replaceSpaceWithPlus: String {
        self.replacingOccurrences(of: " ", with: "+")
    }
    
    var noSpaces: String {
        self.replacingOccurrences(of: " ", with: "")
    }
    
    var lowerNoSpaces: String {
        self.noSpaces.lowercased()
    }
}
