//
//  LoginView.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 17/4/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        VStack(spacing: 12) {
            TextField("Email", text: $viewModel.email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)

            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)

            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            if viewModel.isLoading {
                ProgressView()
            } else {
                Button("Log in") {
                    viewModel.login()
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}
