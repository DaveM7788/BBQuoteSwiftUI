//
//  Character.swift
//  BBQuoteSwiftUI
//
//  Created by David McDermott on 9/9/23.
//

import Foundation

struct Character: Decodable {
    let name: String
    let birthday: String
    let occupations: [String]
    let images: [URL]
    let aliases: [String]
    let portrayedBy: String
}
