//
//  Endpoint.swift
//  expense-app
//
//  Created by Juan Olivera on 7/4/26.
//
import Foundation

enum HTTPMethod: String {
    case get = "GET", post = "POST", put = "PUT", delete = "DELETE", patch = "PATCH"
}

struct Endpoint {
    var path: String
    var method: HTTPMethod = .get
    var headers: [String: String] = [:]
    var body: Encodable?
    var queryItems: [URLQueryItem] = []

    func urlRequest(baseURL: URL) throws -> URLRequest {
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true)
        if !queryItems.isEmpty { components?.queryItems = queryItems }

        guard let url = components?.url else { throw NetworkError.invalidURL }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        if let body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        return request
    }
}
