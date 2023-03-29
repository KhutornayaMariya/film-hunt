//
//  NetworkError.swift
//  
//
//  Created by Mariya Khutornaya on 21.03.23.
//

import Foundation

public enum NetworkError: Error {
    
    case noConnection
    case emptyResult
    case invalidURL
    case serverError
    case unknown
}
