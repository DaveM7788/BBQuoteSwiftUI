//
//  FetchController.swift
//  BBQuoteSwiftUI
//
//  Created by David McDermott on 9/9/23.
//

import Foundation

struct FetchController {
    enum NetworkError: Error {
        case badUrl, badResponse
    }
    private let baseUrl = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    func fetchQuote(from show: String) async throws -> Quote {
        // like this  url?production=Breaking+Bad
        let quoteUrl = baseUrl.appending(path: "quotes/random")
        var quoteComponents = URLComponents(url: quoteUrl, resolvingAgainstBaseURL: true)
        let quoteQueryItem = URLQueryItem(name: "production", value: show.replaceSpaceWithPlus)
        quoteComponents?.queryItems = [quoteQueryItem]
        
        guard let fetchUrl = quoteComponents?.url else {
            throw NetworkError.badUrl
        }
        
        // await means run in background. don't block main thread. try means could have error
        let (data, response) = try await URLSession.shared.data(from: fetchUrl)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let quote = try JSONDecoder().decode(Quote.self, from: data)
        
        return quote
    }
    
    func fetchCharacter(_ name: String) async throws -> Character {
        let characterUrl = baseUrl.appending(path: "characters")
        var characterComponents = URLComponents(url: characterUrl, resolvingAgainstBaseURL: true)
        let characterQueryItem = URLQueryItem(name: "name", value: name.replaceSpaceWithPlus)
        characterComponents?.queryItems = [characterQueryItem]
        
        guard let fetchUrl = characterComponents?.url else {
            throw NetworkError.badUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: fetchUrl)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
            
        let characters = try decoder.decode([Character].self, from: data)
        
        // how API works. it returns multiple characters hence the [Character], but we want to return 1
        // searches by name. There are 2 walters. Even if there is one. API still returns as collection
        return characters[0]
    }
}
