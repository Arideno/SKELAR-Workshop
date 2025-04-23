//
//  LoginViewModel.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 17/4/25.
//

import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var isLoading = false

    func login() {
        errorMessage = nil

        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Введи email і пароль"
            return
        }

        isLoading = true

        Task {
            do {
                try await AuthService.shared.login(email: email, password: password)
                isLoading = false
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }
}
