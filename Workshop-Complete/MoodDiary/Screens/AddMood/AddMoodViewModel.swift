//
//  AddMoodViewModel.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 13/4/25.
//

import Foundation
import SwiftData
import UIKit
import CoreLocation

@MainActor
final class AddMoodViewModel: ObservableObject {
    @Published var selectedMood: MoodType = .happy
    @Published var note: String = ""
    @Published var selectedImage: UIImage?
    @Published var location: CLLocationCoordinate2D?

    private let context: ModelContext = SwiftDataContainer.shared.mainContext
    private let locationService = LocationService()
    private let notificationService = NotificationService()

    // MARK: - Public methods

    func fetchLocation() {
        Task {
            let coordinate = await locationService.getCurrentLocation()
            location = coordinate
        }
    }

    func save() {
        let newEntry = MoodEntry(
            mood: selectedMood,
            note: note.isEmpty ? nil : note,
            image: selectedImage,
            location: location,
            isPublished: false
        )

        context.insert(newEntry)
        try? context.save()

        Task {
            await notificationService.scheduleNotification(
                title: "Настрій збережено 📝",
                body: "Заглянь завтра знову 🌤️",
                delay: 10
            )
        }
    }
}
