//
//  SearchResultRepository.swift
//  FilmHunt
//
//  Created by Mariya Khutornaya on 17.03.23.
//

import Foundation
import FilmHunt_Network

protocol SearchResultRepositoryProtocol {
    func fetchSearchResult(by query: String, page: Int) async throws -> SearchResponse
    func fetchSearchResult(by id: String) async throws -> MovieResponse
}

final class SearchResultRepository {
    
    private let networkManager: NetworkManagerProtocol
    private let apiKey: String
    
    init(networkManager: NetworkManagerProtocol = NetworkManager(),
        apiKey: String = "")
    {
        self.networkManager = NetworkManager()
        self.apiKey = Decryptor().getString(from: ServerInfo.encryptedApiKey)
    }
    
    private enum Query {
        static let searchByQuery = "s"
        static let searchById = "i"
        static let apiKey = "apikey"
        static let page = "page"
        static let plot = "plot"
    }
    
    private func searchByQueryApiUrl(query: String, page: Int = 1) -> URL? {
        let queryItems = [URLQueryItem(name: Query.searchByQuery, value: query),
                          URLQueryItem(name: Query.apiKey, value: apiKey),
                          URLQueryItem(name: Query.page, value: String(page))]
        
        return url(queryItems: queryItems)
    }
    
    private func searchByIdApiUrl(id: String) -> URL? {
        let queryItems = [URLQueryItem(name: Query.searchById, value: id),
                          URLQueryItem(name: Query.apiKey, value: apiKey),
                          URLQueryItem(name: Query.plot, value: "full")]
        
        return url(queryItems: queryItems)
    }
    
    private func url(queryItems: [URLQueryItem]) -> URL? {
        var urlComponents = URLComponents(string: ServerInfo.api)
        urlComponents?.queryItems = queryItems
        return urlComponents?.url
    }
}

extension SearchResultRepository: SearchResultRepositoryProtocol {
    
    func fetchSearchResult(by query: String, page: Int = 1) async throws -> SearchResponse {
        let trimmedQuery = query.trimLeadingAndTrailingWhitespaces()
        let url = searchByQueryApiUrl(query: trimmedQuery, page: page)
        return try await networkManager.request(url: url)
    }
    
    func fetchSearchResult(by id: String) async throws -> MovieResponse {
        let url = searchByIdApiUrl(id: id)
        
        return try await networkManager.request(url: url)
    }
}
