//
//  NetworkError+Extensions.swift
//  FilmHunt
//
//  Created by Mariya Khutornaya on 21.03.23.
//

import Foundation
import FilmHunt_Network

extension NetworkError {
    
    func errorImage() -> String {
        switch self {
        case .noConnection:
            return "wifi"
        case .serverError:
            return "desktopcomputer.trianglebadge.exclamationmark"
        case .invalidURL, .unknown:
            return "exclamationmark.brakesignal"
        case .emptyResult:
            return "questionmark.video.fill"
        }
    }
    
    func errorMessage() -> String {
        switch self {
        case .noConnection:
            return "NO_CONNECTION".localized
        case .serverError:
            return "SERVER_ERROR".localized
        case .invalidURL, .unknown:
            return "ERROR".localized
        case .emptyResult:
            return "EMPTY_RESULT".localized
        }
    }
}
