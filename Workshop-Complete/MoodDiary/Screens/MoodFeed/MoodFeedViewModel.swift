//
//  MoodFeedViewModel.swift
//  MoodDiary
//
//  Created by Andrii Moisol on 19/4/25.
//

import Foundation

@MainActor
final class MoodFeedViewModel: ObservableObject {
    enum State {
        case loading
        case error(Error)
        case data([Mood])

        var isError: Bool {
            guard case .error = self else { return false }
            return true
        }
    }

    @Published private(set) var state: State = .loading

    func onAppear() {
        Task {
            await refresh()
        }
    }

    func refresh() async {
        if state.isError {
            state = .loading
        }

        do {
            state = .data(try await HTTPService.shared.getAllMoods().map(Mood.init))
        } catch {
            state = .error(error)
        }
    }
}
