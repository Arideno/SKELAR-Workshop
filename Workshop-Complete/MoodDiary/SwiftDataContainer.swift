//
//  SwiftDataContainer.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 13/4/25.
//

import Foundation
import SwiftData

enum SwiftDataContainer {
    static let shared: ModelContainer = {
        let schema = Schema([MoodEntry.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("❌ Failed to create SwiftData container: \(error)")
        }
    }()
}
