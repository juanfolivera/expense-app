//
//  SignUpView.swift
//  expense-app
//
//  Created by Juan Olivera on 8/4/26.
//

import SwiftUI

struct SignUpView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @ObservedObject var enrollmentViewModel: EnrollmentViewModel

    var body: some View {
        ZStack {
            Color(hex: "#272f32").ignoresSafeArea()
            VStack {
                Text(L10n.SignUp.title)
                    .font(.system(size: 42, weight: .bold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                Form {
                    TextField(L10n.Username.placeholder, text: $username)
                    SecureField(L10n.Password.placeholder, text: $password)
                    SecureField(L10n.ConfirmPassword.placeholder, text: $confirmPassword)
                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                Spacer()
                Button {
                    if password == confirmPassword {
                        Task {
                            enrollmentViewModel.error = nil
                            await enrollmentViewModel.signUp(username: username.lowercased(),
                                                             password: password.lowercased())
                            if enrollmentViewModel.error == nil {
                                await enrollmentViewModel.signIn(username: username,
                                                                 password: password)
                            }
                        }
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text(L10n.SignUp.action)
                            .font(.system(size: 25, weight: .bold))
                            .foregroundStyle(Color.white)
                            .padding()
                        Spacer()
                    }
                    .background(Color(hex: "#272f32"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    NavigationStack {
        SignUpView(enrollmentViewModel: EnrollmentViewModel())
    }
}
