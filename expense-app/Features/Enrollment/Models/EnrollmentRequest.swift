//
//  EnrollmentRequest.swift
//  expense-app
//
//  Created by Juan Olivera on 14/4/26.
//

struct EnrollmentRequest {
    var username: String
    var password: String

    func toJson() -> [String: String] {
        return ["username": username,
                "password": password]
    }
}

struct LoginResponse: Codable {
    var accessToken: String
    var refreshToken: String
    var tokenType: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
    }
}

struct RegisterResponse: Codable {
    var id: Int
    var username: String

    enum CodingKeys: String, CodingKey {
        case id, username
    }
}
