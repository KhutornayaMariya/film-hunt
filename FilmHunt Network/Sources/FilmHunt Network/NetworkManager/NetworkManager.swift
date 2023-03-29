//
//  NetworkManager.swift
//  
//
//  Created by Mariya Khutornaya on 21.03.23.
//

import Foundation

public protocol NetworkManagerProtocol {
    func request<Item: Decodable>(url: URL?) async throws -> Item
}

public final class NetworkManager: NetworkManagerProtocol {
    
    public init() {}
    
    public func request<Item: Decodable>(url: URL?) async throws -> Item {
        
        guard let url = url else {
            throw NetworkError.invalidURL
        }
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw NetworkError.noConnection
        }
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.serverError
        }
        
        do {
            return try JSONDecoder().decode(Item.self, from: data)
        } catch _ {
            throw NetworkError.emptyResult
        }
    }
}
