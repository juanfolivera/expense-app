//
//  NetworkClient.swift
//  expense-app
//
//  Created by Juan Olivera on 8/4/26.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
extension URLSession: URLSessionProtocol {}

final class NetworkClient {
    static let shared = NetworkClient()

    private let baseURL: URL?
    private let session: URLSessionProtocol
    private let decoder: JSONDecoder

    init(
        baseURL: URL? = URL(string: "https://expenses-api-h0sm.onrender.com"),
        session: URLSessionProtocol = URLSession.shared
    ) {
        self.baseURL = baseURL
        self.session = session
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder.dateDecodingStrategy = .iso8601
    }

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let baseURL else {
            throw NetworkError.invalidURL
        }
        let urlRequest = try endpoint.urlRequest(baseURL: baseURL)

        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await session.data(for: urlRequest)
        } catch let urlError as URLError where urlError.code == .notConnectedToInternet {
            throw NetworkError.noConnection
        }

        try validate(response: response, data: data)

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }

    func requestVoid(_ endpoint: Endpoint) async throws {
        guard let baseURL else {
            throw NetworkError.invalidURL
        }
        let urlRequest = try endpoint.urlRequest(baseURL: baseURL)
        let (data, response) = try await session.data(for: urlRequest)
        try validate(response: response, data: data)
    }

    private func validate(response: URLResponse, data: Data) throws {
        guard let http = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        switch http.statusCode {
        case 200..<300:
            break
        case 401:
            throw NetworkError.unauthorized
        default:
            throw NetworkError.httpError(statusCode: http.statusCode, data: data)
        }
    }
}
