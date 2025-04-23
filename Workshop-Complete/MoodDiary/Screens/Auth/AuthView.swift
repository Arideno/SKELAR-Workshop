//
//  AuthView.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 16/4/25.
//

import SwiftUI

enum AuthMode: String, CaseIterable, Identifiable {
    case register = "Register"
    case login = "Log in"

    var id: String { rawValue }
}

struct AuthView: View {
    @State private var selectedMode: AuthMode = .register

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Picker("", selection: $selectedMode) {
                    ForEach(AuthMode.allCases) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(.segmented)

                if selectedMode == .register {
                    RegisterView()
                } else {
                    LoginView()
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Authorization")
        }
    }
}
