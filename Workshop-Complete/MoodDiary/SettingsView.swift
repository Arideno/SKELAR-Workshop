//
//  SettingsView.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 16/4/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var showLogoutAlert = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Button("Sign out", role: .destructive) {
                        showLogoutAlert = true
                    }
                }
            }
            .navigationTitle("Settings")
            .alert("Sign out from account?", isPresented: $showLogoutAlert) {
                Button("Sign out", role: .destructive) {
                    do {
                        try AuthService.shared.logout()
                    } catch {
                        print("Logout error: \(error)")
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
}
