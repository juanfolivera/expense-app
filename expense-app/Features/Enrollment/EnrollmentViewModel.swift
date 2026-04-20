//
//  EnrollmentViewModel.swift
//  expense-app
//
//  Created by Juan Olivera on 8/4/26.
//
import Foundation
import SwiftUI
import Combine

class EnrollmentViewModel: ObservableObject {
    @Published var error: NetworkError?
    @Published var isLoading = false
    @Published var signInResponse: LoginResponse?
    @Published var signUpResponse: RegisterResponse?

    private let client = NetworkClient.shared

    func signIn(username: String, password: String) async {
        isLoading = true
        defer { isLoading = false }
        do {
            self.signInResponse = try await client.request(.login(enrollmentRequest:
                                                                    EnrollmentRequest(username: username,
                                                                                      password: password)))
            UserDefaults.standard.set(signInResponse?.accessToken, forKey: "accessToken")
            UserDefaults.standard.set(signInResponse?.refreshToken, forKey: "refreshToken")
        } catch let networkError as NetworkError {
            self.error = networkError
        } catch {
            self.error = .invalidResponse
        }
    }

    func signUp(username: String, password: String) async {
        isLoading = true
        defer { isLoading = false }
        do {
            self.signUpResponse = try await client.request(.register(enrollmentRequest:
                                                                        EnrollmentRequest(username: username,
                                                                                          password: password)))
        } catch let networkError as NetworkError {
            self.error = networkError
        } catch {
            self.error = .invalidResponse
        }
    }
}
