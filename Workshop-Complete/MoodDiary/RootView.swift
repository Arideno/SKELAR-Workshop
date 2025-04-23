//
//  RootView.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 16/4/25.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authService: AuthService

    var body: some View {
        Group {
            if authService.isLoggedIn {
                TabView {
                    Tab("My Moods", systemImage: "cloud") {
                        MoodListView()
                    }

                    Tab("Mood Feed", systemImage: "cloud.fill") {
                        MoodFeedView()
                    }

                    Tab("Settings", systemImage: "gear") {
                        SettingsView()
                    }
                }
            } else {
                AuthView()
            }
        }
        .animation(.default, value: AuthService.shared.isLoggedIn)
    }
}
