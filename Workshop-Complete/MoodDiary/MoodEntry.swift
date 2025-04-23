//
//  MoodEntry.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 13/4/25.
//

import Foundation
import SwiftData
import CoreLocation
import UIKit

@Model
final class MoodEntry {
    @Attribute(.unique) var id: UUID
    var mood: MoodType
    var note: String?
    var date: Date
    var imageData: Data?
    var latitude: Double?
    var longitude: Double?
    var isPublished: Bool

    init(
        id: UUID = UUID(),
        mood: MoodType,
        note: String? = nil,
        date: Date = .now,
        image: UIImage? = nil,
        location: CLLocationCoordinate2D? = nil,
        isPublished: Bool
    ) {
        self.id = id
        self.mood = mood
        self.note = note
        self.date = date
        self.isPublished = isPublished

        if let image = image {
            self.imageData = image.jpegData(compressionQuality: 0.8)
        }

        if let location = location {
            self.latitude = location.latitude
            self.longitude = location.longitude
        }
    }
}
