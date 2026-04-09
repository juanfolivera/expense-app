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

    var body: some View {
        ZStack {
            Color(hex: "#272f32")
                .ignoresSafeArea()
            Text("Keep your expenses on point.")
                .font(.system(size: 42, weight: .bold))
                .foregroundStyle(Color.white)
                .padding()
        }
        .sheet(isPresented: .constant(true)) {
            VStack {
                Form {
                    TextField("Username", text: $username)
                    SecureField("Password", text: $password)
                }
                Button {

                } label: {
                    HStack {
                        Spacer()
                        Text("Sign In")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundStyle(Color.white)
                            .padding()
                        Spacer()
                    }
                    .background(Color(hex: "#272f32"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                }
                Button {

                } label: {
                    Text("I don't have an account")
                        .foregroundStyle(Color(hex: "#272f32"))
                }
            }
            .presentationDetents([.fraction(0.35)])
            .interactiveDismissDisabled(true)
        }
    }
}

#Preview {
    SignInView()
}
