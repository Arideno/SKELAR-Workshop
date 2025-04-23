//
//  Mood.swift
//  Workshop
//
//  Created by Andrii Moisol on 23/4/25.
//

import UIKit
import CoreLocation

struct Mood {
    let id: UUID
    let type: MoodType
    let note: String?
    let date: Date
    let image: UIImage?
    let coordinate: CLLocationCoordinate2D?
}

enum MoodType: String, CaseIterable {
    case happy, sad, tired, angry, calm

    var emoji: String {
        switch self {
        case .happy: "😊"
        case .sad: "😢"
        case .tired: "🥱"
        case .angry: "😠"
        case .calm: "😌"
        }
    }
}
