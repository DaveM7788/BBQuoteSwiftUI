//
//  Constants.swift
//  BBQuoteSwiftUI
//
//  Created by David McDermott on 9/9/23.
//

import Foundation

extension String {
    var replaceSpaceWithPlus: String {
        self.replacingOccurrences(of: " ", with: "+")
    }
}
