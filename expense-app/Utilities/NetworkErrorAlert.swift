//
//  NetworkErrorAlert.swift
//  expense-app
//
//  Created by Juan Olivera on 15/4/26.
//

import SwiftUI

struct NetworkErrorAlert: ViewModifier {
    @Binding var error: NetworkError?

    private var isPresented: Binding<Bool> {
        Binding(
            get: { error != nil },
            set: { if !$0 { error = nil } }
        )
    }

    func body(content: Content) -> some View {
        content
            .alert(
                L10n.Error.title,
                isPresented: isPresented,
                presenting: error
            ) { error in
                if error.isRetryable {
                    Button(L10n.Error.retry) { }
                }
                Button(L10n.Error.action, role: .cancel) { self.error = nil }
            } message: { error in
                Text(error.localizedDescription)
            }
    }
}

extension View {
    func networkErrorAlert(error: Binding<NetworkError?>) -> some View {
        modifier(NetworkErrorAlert(error: error))
    }
}
