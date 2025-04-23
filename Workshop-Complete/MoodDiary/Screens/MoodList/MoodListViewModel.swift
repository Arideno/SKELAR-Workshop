//
//  MoodListViewModel.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 13/4/25.
//

import Foundation
import SwiftData

@MainActor
final class MoodListViewModel: ObservableObject {
    @Published private(set) var moods: [Mood] = []
    @Published private(set) var errorMessage: String?

    private let context: ModelContext = SwiftDataContainer.shared.mainContext
    private let locationService = LocationService()
    private let notificationService = NotificationService()
    private var entries: [MoodEntry] = []

    func onAppear() {
        locationService.askForPermissionIfNeeded()
        fetch()

        Task {
            await notificationService.requestPermission()
        }
    }

    func fetch() {
        let descriptor = FetchDescriptor<MoodEntry>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )

        do {
            entries = try context.fetch(descriptor)
            moods = entries.map(Mood.init)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func delete(mood: Mood) {
        guard let entry = entries.first(where: { $0.id == mood.id }) else { return }
        context.delete(entry)

        do {
            try context.save()
            fetch()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func publish(mood: Mood) {
        guard let entry = entries.first(where: { $0.id == mood.id }) else { return }
        Task {
            do {
                try await HTTPService.shared.publishMood(mood)
                
                entry.isPublished = true
                try context.save()
                fetch()
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
