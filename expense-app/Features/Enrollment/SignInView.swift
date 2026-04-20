//
//  SignInView.swift
//  expense-app
//
//  Created by Juan Olivera on 8/4/26.
//

import SwiftUI

struct SignInView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var path = NavigationPath()
    @State private var showLoginSheet = true
    @ObservedObject var enrollmentViewModel: EnrollmentViewModel

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                ZStack {
                    Color(hex: "#272f32")
                        .ignoresSafeArea()
                    Text(L10n.SignIn.title)
                        .font(.system(size: 42, weight: .bold))
                        .foregroundStyle(Color.white)
                        .padding()
                }
                VStack {
                    Form {
                        TextField(L10n.Username.placeholder, text: $username)
                        SecureField(L10n.Password.placeholder, text: $password)
                    }
                    Button {
                        Task {
                            enrollmentViewModel.error = nil
                            await enrollmentViewModel.signIn(username: username.lowercased(),
                                                             password: password.lowercased())
                            if enrollmentViewModel.error == nil {
                                path.append(AppRoute.dashboard)
                            }
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text(L10n.SignIn.action)
                                .font(.system(size: 17, weight: .bold))
                                .foregroundStyle(Color.white)
                                .padding()
                            if enrollmentViewModel.isLoading {
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .tint(.white)
                            }
                            Spacer()
                        }
                        .background(Color(hex: "#272f32"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                    }
                    .disabled(enrollmentViewModel.isLoading)

                    Button(L10n.SignIn.Secondary.action) {
                        showLoginSheet = false
                        path.append(AppRoute.signUp)
                    }
                    .foregroundStyle(Color(hex: "#272f32"))
                }
                .background(Color(uiColor: UIColor.groupTableViewBackground))
                .frame(maxHeight: 300)
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .signUp:
                    SignUpView(enrollmentViewModel: enrollmentViewModel)
                case .dashboard:
                    DashboardView()
                }
            }
            .onAppear {
                showLoginSheet = true
            }
            .networkErrorAlert(error: $enrollmentViewModel.error)
        }
    }
}

#Preview {
    SignInView(enrollmentViewModel: EnrollmentViewModel())
}
