//
//  AuthService.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 16/4/25.
//

import Foundation
import FirebaseAuth

@MainActor
final class AuthService: ObservableObject {
    static let shared = AuthService()
    private init() {
        isLoggedIn = Auth.auth().currentUser != nil
    }

    @Published private(set) var isLoggedIn: Bool

    func register(email: String, password: String) async throws {
        let _ = try await Auth.auth().createUser(withEmail: email, password: password)
        isLoggedIn = true
    }

    func logout() throws {
        try Auth.auth().signOut()
        isLoggedIn = false
    }

    func login(email: String, password: String) async throws {
        let _ = try await Auth.auth().signIn(withEmail: email, password: password)
        isLoggedIn = true
    }

    func getToken() async -> String? {
        try? await Auth.auth().currentUser?.getIDToken()
    }
}
