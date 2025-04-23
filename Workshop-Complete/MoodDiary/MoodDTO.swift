//
//  MoodDTO.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 17/4/25.
//

import Foundation

struct MoodDTO: Codable {
    let id: UUID
    let type: String
    let note: String?
    let date: Date
    let latitude: Double?
    let longitude: Double?
}
