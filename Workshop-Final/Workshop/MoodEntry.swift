//
//  MoodEntry.swift
//  Workshop
//
//  Created by Andrii Moisol on 23/4/25.
//

import Foundation
import SwiftData

@Model
class MoodEntry {
    @Attribute(.unique) var id: UUID
    var type: String
    var note: String?
    var imageData: Data?
    var date: Date
    var latitude: Double?
    var longitude: Double?
    var isPublished: Bool

    init(
        id: UUID,
        type: String,
        note: String? = nil,
        imageData: Data? = nil,
        date: Date,
        latitude: Double? = nil,
        longitude: Double? = nil,
        isPublished: Bool
    ) {
        self.id = id
        self.type = type
        self.note = note
        self.imageData = imageData
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
        self.isPublished = isPublished
    }
}
