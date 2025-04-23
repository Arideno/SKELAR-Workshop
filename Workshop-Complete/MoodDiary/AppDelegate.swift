//
//  AppDelegate.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 15/4/25.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()

        return true
    }
}
