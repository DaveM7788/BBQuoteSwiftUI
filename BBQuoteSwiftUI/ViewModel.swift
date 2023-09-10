//
//  ViewModel.swift
//  BBQuoteSwiftUI
//
//  Created by David McDermott on 9/9/23.
//

import Foundation

// in swift a struct harder to edit it afterwards.
// class can have multiple properties point to same class

// main actor means run on main thread
@MainActor
class ViewModel: ObservableObject {
    enum Status {
        case notStarted
        case fetching
        case success(data: (quote: Quote, character: Character))
        case failed(error: Error)
    }
    
    // property that view can observe. requires observableobject above
    @Published private(set) var status: Status = .notStarted
    
    private let controller: FetchController
    
    init(controller: FetchController) {
        self.controller = controller
    }
    
    func getData(for show: String) async {
        status = .fetching
        do {
            let quote = try await controller.fetchQuote(from: show)
            let character = try await controller.fetchCharacter(quote.character)
            status = .success(data: (quote, character))
        } catch {
            status = .failed(error: error)
        }
    }
}
