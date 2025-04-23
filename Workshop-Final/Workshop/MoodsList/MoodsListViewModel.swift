//
//  MoodsListViewModel.swift
//  Workshop
//
//  Created by Andrii Moisol on 23/4/25.
//

import UIKit
import SwiftData
import CoreLocation

@MainActor
class MoodsListViewModel: ObservableObject {
    @Published var moods: [Mood] = []

    private var moodEntries: [MoodEntry] = []
    private let context = SwiftDataContainer.shared.mainContext

    func onAppear() {
        let locationService = LocationService()
        locationService.askForPermission()

        fetchMoods()
    }

    func delete(mood: Mood) {
        guard let entry = moodEntries.first(where: { $0.id == mood.id }) else { return }
        context.delete(entry)
        try? context.save()

        fetchMoods()
    }

    private func fetchMoods() {
        let fetchDescriptor = FetchDescriptor<MoodEntry>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )

        moodEntries = try! context.fetch(fetchDescriptor)
        moods = moodEntries.map { entry in
            var image: UIImage?
            var coordinate: CLLocationCoordinate2D?
            if let data = entry.imageData {
                image = UIImage(data: data)
            }
            if let latitude = entry.latitude, let longitude = entry.longitude {
                coordinate = CLLocationCoordinate2D(
                    latitude: latitude,
                    longitude: longitude
                )
            }
            return Mood(
                id: entry.id,
                type: MoodType(rawValue: entry.type) ?? .happy,
                note: entry.note,
                date: entry.date,
                image: image,
                coordinate: coordinate
            )
        }
    }
}
