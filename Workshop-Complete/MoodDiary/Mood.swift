//
//  Mood.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 17/4/25.
//

import UIKit
import CoreLocation
import MapKit

struct Mood: Identifiable {
    let id: UUID
    let type: MoodType
    let note: String?
    let date: Date
    let image: UIImage?
    let coordinate: CLLocationCoordinate2D?
    let isPublished: Bool
}

extension Mood {
    init(entry: MoodEntry) {
        id = entry.id
        type = entry.mood
        note = entry.note
        date = entry.date
        if let imageData = entry.imageData {
            image = UIImage(data: imageData)
        } else {
            image = nil
        }
        if let latitude = entry.latitude, let longitude = entry.longitude {
            coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            coordinate = nil
        }
        isPublished = entry.isPublished
    }

    init(moodDTO: MoodDTO) {
        id = moodDTO.id
        type = MoodType(rawValue: moodDTO.type) ?? .happy
        note = moodDTO.note
        date = moodDTO.date
        image = nil
        if let latitude = moodDTO.latitude, let longitude = moodDTO.longitude {
            coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            coordinate = nil
        }
        isPublished = true
    }
}
