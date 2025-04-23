//
//  SwiftDataContainer.swift
//  Workshop
//
//  Created by Andrii Moisol on 23/4/25.
//

import Foundation
import SwiftData

struct SwiftDataContainer {
    static let shared: ModelContainer = {
        let schema = Schema([MoodEntry.self])
        let configuration = ModelConfiguration(schema: schema)

        let container = try! ModelContainer(for: schema, configurations: [configuration])
        return container
    }()
}
