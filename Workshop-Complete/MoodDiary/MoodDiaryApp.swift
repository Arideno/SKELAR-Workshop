//
//  MoodDiaryApp.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 13/4/25.
//

import SwiftUI
import SwiftData

@main
struct MoodDiaryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .environmentObject(AuthService.shared)
    }
}
