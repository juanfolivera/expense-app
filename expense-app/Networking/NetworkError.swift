//
//  NetworkError.swift
//  expense-app
//
//  Created by Juan Olivera on 7/4/26.
//
import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int, data: Data)
    case decodingError(Error)
    case unauthorized
    case noConnection

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid Response"
        case .unauthorized:
            return "Session expired. Please try again"
        case .noConnection:
            return "No internet connection"
        case .httpError(let code, _):
            return "Server error: (\(code))"
        case .decodingError(let error):
            return "Error processing response: \(error.localizedDescription)"
        }
    }

    /// Checks if worth retry
    var isRetryable: Bool {
        switch self {
        case .httpError(let code, _):
            return code >= 500
        case .noConnection:
            return true
        default:
            return false
        }
    }
}
