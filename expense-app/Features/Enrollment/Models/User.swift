//
//  User.swift
//  expense-app
//
//  Created by Juan Olivera on 13/4/26.
//

struct User: Codable {
    var id: Int
    var username: String

    enum CodingKeys: String, CodingKey {
        case id, username
    }
}
