//
//  AddMoodViewModel.swift
//  Workshop
//
//  Created by Andrii Moisol on 23/4/25.
//

import UIKit

@MainActor
class AddMoodViewModel: ObservableObject {
    @Published var selectedMoodType: MoodType = .happy
    @Published var note = ""
    @Published var selectedPhotoImage: UIImage?
    @Published var shouldClose: Bool = false

    let locationService = LocationService()

    func save() {
        locationService.getCurrentLocation { coordinate in
            let moodEntry = MoodEntry(
                id: UUID(),
                type: self.selectedMoodType.rawValue,
                note: self.note,
                imageData: self.selectedPhotoImage?.jpegData(compressionQuality: 0.6),
                date: .now,
                latitude: coordinate.latitude,
                longitude: coordinate.longitude,
                isPublished: false
            )

            let context = SwiftDataContainer.shared.mainContext
            context.insert(moodEntry)
            try? context.save()
            self.shouldClose = true
        }
    }
}
