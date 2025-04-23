//
//  MoodType.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 13/4/25.
//

import Foundation
import SwiftUI

enum MoodType: String, CaseIterable, Identifiable, Codable {
    case happy
    case sad
    case tired
    case angry
    case calm

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .happy: "😊"
        case .sad: "😢"
        case .tired: "🥱"
        case .angry: "😠"
        case .calm: "😌"
        }
    }

    var title: String {
        switch self {
        case .happy: "Happy"
        case .sad: "Sad"
        case .tired: "Tired"
        case .angry: "Angry"
        case .calm: "Calm"
        }
    }
}
