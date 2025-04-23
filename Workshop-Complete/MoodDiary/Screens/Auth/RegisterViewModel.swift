//
//  RegisterViewModel.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 16/4/25.
//

import Foundation

@MainActor
final class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var isSuccess: Bool = false

    func register() {
        errorMessage = nil

        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Enter email and password"
            return
        }

        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters long"
            return
        }

        guard password == confirmPassword else {
            errorMessage = "Passwords do not match"
            return
        }

        isLoading = true

        Task {
            do {
                try await AuthService.shared.register(email: email, password: password)
                await MainActor.run {
                    isLoading = false
                }
            } catch {
                await MainActor.run {
                    errorMessage = error.localizedDescription
                    isLoading = false
                }
            }
        }
    }
}
