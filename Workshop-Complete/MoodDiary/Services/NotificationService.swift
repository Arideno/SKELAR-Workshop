//
//  NotificationService.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 17/4/25.
//

import Foundation
import UserNotifications

final class NotificationService {
    private let center = UNUserNotificationCenter.current()

    func requestPermission() async -> Bool {
        do {
            let granted = try await center.requestAuthorization(options: [.alert, .sound, .badge])
            return granted
        } catch {
            print("❌ Не вдалося отримати дозвіл на нотифікації:", error)
            return false
        }
    }

    func scheduleNotification(title: String, body: String, delay: TimeInterval) async {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delay, repeats: false)
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        try? await center.add(request)
    }
}
